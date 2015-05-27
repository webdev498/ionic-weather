`import Ember from 'ember'`

SmartlinkControllerIndexView = Ember.View.extend
  didInsertElement: ->
    @setupPullToRefresh()
    @setupCommLog()

  setupPullToRefresh: ->
    view = this
    @$('#smartlink-controller-container').xpull(
      callback: ->
        view.get('controller').send('refreshData')
      pullThreshold: 35
      spinnerTimeout: 1
      loadingHtml: @pullToRefreshLoadingHtml
    )

    pullToRefreshLoadingHtml: '
      <div class="pull-indicator">
        <div class="arrow-body"></div>
        <div class="triangle-down"></div>
      </div>
    '

  setupCommLog: ->
    if @get('controller.showCommLog')
      openCommLog = ->
        @get('controller').setProperties({
          isCommLogOpen: true
          showCommLog: false
        })
      Ember.run.later(this, openCommLog, 500)

`export default SmartlinkControllerIndexView`
