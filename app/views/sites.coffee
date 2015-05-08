`import Ember from 'ember'`

SitesView = Ember.View.extend
  didInsertElement: ->
    @setupPullToRefresh()
    @setupScrolling()

  willDestroyElement: ->
    @stopScrollingPoll()

  setupPullToRefresh: ->
    view = this
    @$('#sites-list-container').xpull(
      callback: ->
        view.get('controller').send('refreshData')
      pullThreshold: 35
      spinnerTimeout: 1
      loadingHtml: @pullToRefreshLoadingHtml
    )

  setupScrolling: ->
    # I'm polling for scroll end (i.e. the 'load more' element has been scrolled
    # into the viewport) because it works better than anything I could come up
    # with on binding to scroll events.  The problem was on mobile devices if you
    # start scrolling and let "intertia" bring you to the bottom of the page, the
    # "check if wer're at bottom of page" logic might not work since the actual
    # scrolling stopped before we got to the end of the page.  Instead I'm
    # periodically polling to see if the 'load more' element is currently visible
    # (load more data if it is).
    #
    # TODO: There may be a more "ember" way to do this, see here:
    # https://medium.com/delightful-ui-for-ember-apps/ember-js-detecting-if-a-dom-element-is-in-the-viewport-eafcc77a6f86
    view = this

    scrollingPollIntervalId = setInterval ->
      view.checkForScrolledToBottom()
    , 500

    @set('scrollingPollIntervalId', scrollingPollIntervalId)

  stopScrollingPoll: ->
    clearInterval @get('scrollingPollIntervalId')

  checkForScrolledToBottom: ->
    loadingIcon = Ember.$('.loading-icon')
    if this.isElementInViewport loadingIcon
      @get('controller').send('loadMoreSites') unless @get('controller.isLoading')

  # taken from here:
  # http://stackoverflow.com/questions/123999/how-to-tell-if-a-dom-element-is-visible-in-the-current-viewport
  isElementInViewport: (el) ->
    if el instanceof Ember.$
      el = el[0]

    rect = el.getBoundingClientRect()

    (
      rect.top >= -100 &&
      rect.left >= 0 &&
      rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
      rect.right <= (window.innerWidth || document.documentElement.clientWidth)
    )

  pullToRefreshLoadingHtml: '
    <div class="pull-indicator">
      <div class="arrow-body"></div>
      <div class="triangle-down"></div>
    </div>
  '

`export default SitesView`
