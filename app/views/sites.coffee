`import Ember from 'ember'`

SitesView = Ember.View.extend
  templateName: 'sites'

  didInsertElement: ->
    # I'm polling for scroll end because it works better than anything
    # I could come up with on binding to scroll events.  The problem was on
    # mobile devices if you start scrolling and let 'intertia' bring you to the
    # bottom of the page, the 'check if at bottom of page' event wouldn't always
    # fire.  Instead I'm just periodically polling whether the 'loading' element
    # is currently visible in the view (load more data if it is).
    #
    # TODO: There may be a better way to do this, see here:
    # https://medium.com/delightful-ui-for-ember-apps/ember-js-detecting-if-a-dom-element-is-in-the-viewport-eafcc77a6f86
    view = this

    setInterval ->
      view.checkForScrolledToBottom()
    , 500

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


`export default SitesView`
