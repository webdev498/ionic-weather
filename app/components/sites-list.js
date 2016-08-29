import Ember from 'ember';
import promisedProperty from '../util/promised-property';

const {
  Component,
  Logger: { debug },
  RSVP: { Promise },
  inject: { service },
  computed, observer
} = Ember;

export default Component.extend({

  settings: service('applicationSettings'),

  store: service(),

  sites: service('sites'),

  nextPageToLoad: 2,

  isOptionsMenuOpen: false,

  isSortOptionsOpen: false,

  isSearchEnabled: false,

  willDestroyElement() {
    debug("SitesList.willDestroyElement()")
    this.stopScrollingPoll()
  },

  searchIcon: computed('isSearchEnabled', function() {
    if (this.get('isSearchEnabled')) {
      return 'icon-close';
    } else {
      return 'icon-search';
    }
  }),

  isSortByProximity: computed('sortMethod', function() {
    return this.get('sortMethod') === 'proximity';
  }),

  isSortByAlpha: computed('sortMethod', function() {
    return this.get('sortMethod') === 'alpha';
  }),

  moreSitesAvailable: computed('model.meta.found', 'model.sites.length', function() {
    var totalSitesCount;
    totalSitesCount = this.get('model.meta.found')
    debug(`SitesList.moreSitesAvailable(), found: ${totalSitesCount}`)
    return totalSitesCount > this.get('model.sites.length');
  }),

  shouldShowLoading: computed('moreSitesAvailable', 'isLoading', 'isSearchApplied', function() {
    var isReloadingAfterSearch;
    isReloadingAfterSearch = this.get('isSearchApplied') && this.get('isLoading');
    return this.get('moreSitesAvailable') || isReloadingAfterSearch;
  }),

  sortMethodDidChange: observer('sortMethod', function() {
    var newSortMethod;
    newSortMethod = this.get('sortMethod');
    this.get('settings').changeSetting('sites-sort-method', newSortMethod);
    return this.send('refreshData');
  }),

  isSearchApplied: false,

  isSearchEmpty: computed('search.length', function() {
    return !this.get('search.length');
  }),

  isSearchEnabledDidChange: observer('isSearchEnabled', function() {
    const search = Ember.$('.weathermatic-sites-search');
    search.toggle('fast', () => {
      if (search.is(':visible')) {
        this.focusSearchField();
      }
    });
    if (!this.get('isSearchApplied')) {
      return;
    }
    const wasSearchDisabled = !this.get('isSearchEnabled');
    const callback = () => {
      return this.set('isSearchApplied', false);
    };
    if (wasSearchDisabled) {
      return this.send('refreshData', callback);
    }
  }),

  focusSearchField() {
    Ember.$('.weathermatic-sites-search input[type=search]').focus();
  },

  appVersion: computed(promisedProperty(null, function() {
    if (typeof cordova !== "undefined" && cordova !== null) {
      return cordova.getAppVersion.getVersionCode();
    } else {
      return Promise.resolve(null);
    }
  })),

  init: function() {
    var defaultSortMethod;
    defaultSortMethod = this.get('settings').getSetting('sites-sort-method');
    this.set('sortMethod', defaultSortMethod);
    this.setupScrolling();
    return this._super(...arguments);
  },

  setupScrolling() {
    // I'm polling for scroll end (i.e. the 'load more' element has been scrolled
    // into the viewport) because it works better than anything I could come up
    // with on binding to scroll events.  The problem was on mobile devices if you
    // start scrolling and let "intertia" bring you to the bottom of the page, the
    // "check if wer're at bottom of page" logic might not work since the actual
    // scrolling stopped before we got to the end of the page.  Instead I'm
    // periodically polling to see if the 'load more' element is currently visible
    // (load more data if it is).
    //
    // TODO: There may be a more "ember" way to do this, see here:
    // https://medium.com/delightful-ui-for-ember-apps/ember-js-detecting-if-a-dom-element-is-in-the-viewport-eafcc77a6f86

    debug("SitesList starting scroll polling");

    const scrollingPollIntervalId = setInterval( () => {
      this.checkForScrolledToBottom();
    }, 500);
    this.set('scrollingPollIntervalId', scrollingPollIntervalId);
  },

  stopScrollingPoll() {
    debug("SitesList stopping scroll polling");
    clearInterval(this.get('scrollingPollIntervalId'));
  },

  checkForScrolledToBottom() {
    if (!this.get('isLoading')) {
      const loadingIcon = Ember.$('.loading-icon');
      if (loadingIcon.length && !this.get('isLoading') && this.isElementInViewport(loadingIcon)) {
        this.send('loadMoreSites');
      }
    }
  },

  // taken from here:
  // http://stackoverflow.com/questions/123999/how-to-tell-if-a-dom-element-is-visible-in-the-current-viewport
  isElementInViewport(el) {
    if (el instanceof Ember.$) {
      el = el[0];
    }
    const rect = el.getBoundingClientRect();
    return rect.top >= -100 &&
      rect.left >= 0 &&
      rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
      rect.right <= (window.innerWidth || document.documentElement.clientWidth);

  },

  actions: {
    openLink(url) {
      this.sendAction('openLink', url)
    },

    goToSite(site) {
      var self;
      if (site.get('controllersCount') === 1) {
        this.get('router').transitionTo('loading');
        self = this;
        return site.get('smartlinkControllers').then(function(controllers) {
          return self.get('router').transitionTo('smartlink-controller', controllers.get('firstObject'));
        });
      } else {
        return this.get('router').transitionTo('site.index', site);
      }
    },

    toggleSearch() {
      this.toggleProperty('isSearchEnabled');
      return false;
    },

    performSearch() {
      this.set('lastSearch', this.get('search'));
      this.set('isSearchApplied', true);
      return this.send('refreshData');
    },

    refreshData(callback) {
      debug('SitesController.refreshData()');
      this.set('isLoading', true);
      this.get('store').unloadAll('zone');
      this.get('store').unloadAll('program');
      this.get('store').unloadAll('fault');
      this.get('store').unloadAll('smartlink-controller');
      this.get('store').unloadAll('site');
      const options = {};
      if (this.get('isSearchEnabled')) {
        options.search = this.get('search');
      }
      var retries = 0;
      const maxRetries = 3;
      const doRefresh = () => {
        return this.get('sites').lookupAndCacheSites(options).then( (sites) => {
          this.set('model', Ember.Object.create({
            sites: sites.toArray(),
            meta: sites.get('meta'),
          }));
        });
      };
      doRefresh().catch( (error) => {
        retries += 1;
        debug('Refresh sites failed, trying again without geolocation');
        this.get('settings').changeSetting('sites-sort-method', 'alpha');
        this.set('sortMethod', 'alpha');
        this.set('geolocationUnavailable', true);
        if (retries <= maxRetries) {
          return doRefresh();
        } else {
          throw new Error(`Too many retries (${retries}) for 'refreshData' action, giving up`);
        }
      }).finally( () => {
        this.set('isLoading', false);
        if (Ember.typeOf(callback) === 'function') {
          return callback();
        }
      });
      return this.set('nextPageToLoad', 2);
    },

    loadMoreSites() {
      debug("SitesList loading more sites");
      if (this.get('isLoading')) {
        return;
      }
      this.set('isLoading', true);
      this.get('sites').lookupSites({
        page: this.get('nextPageToLoad')
      }).then( (moreSites) => {
        this.incrementProperty('nextPageToLoad');
        moreSites.forEach( (site) => {
          this.get('model.sites').pushObject(site);
        });
      }).finally( () => {
        this.set('isLoading', false);
      });
    },

    openOptionsMenu() {
      this.set('isOptionsMenuOpen', true);
    },

    logOut() {
      this.send('closeAllMenus');
      this.sendAction('logOut');
    },

    syncSites() {
      this.send('closeAllMenus');
      return this.send('refreshData');
    },

    closeOptionsMenu() {
      return this.send('closeAllMenus');
    },

    openSortOptions() {
      if (this.get('geolocationUnavailable')) {
        return debug('Geolocation search is not available, not showing sort options');
      } else {
        return this.set('isSortOptionsOpen', true);
      }
    },

    closeSortOptions() {
      return this.send('closeAllMenus');
    },

    closeAllMenus() {
      this.set('isOptionsMenuOpen', false);
      return this.set('isSortOptionsOpen', false);
    },

    setSortMethod(sortMethod) {
      this.set('sortMethod', sortMethod);
      return this.send('closeSortOptions');
    },

    sendFeedback() {
      return this.send('openLink', 'mailto:feedback@smartlinknetwork.com?subject=Mobile App Feedback');
    },

    launchFullSite: function() {
      return this.send('openLink', 'http://my.smartlinknetwork.com/users/sign_in');
    }
  }
});
