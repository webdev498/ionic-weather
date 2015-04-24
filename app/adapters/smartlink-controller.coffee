`import ApplicationAdapter from './application'`

SmartlinkControllerAdapter = ApplicationAdapter.extend
  pathForType: -> 'controllers'

  ajaxOptions: (url, type, options) ->
    options = options || {}
    options.data = options.data || {}

    extraQueryParams = {
      embed_zones: true,
      include_links: false,
      include_permissions: false
    }

    Ember.merge(options.data, extraQueryParams)
    this._super(url, type, options)

`export default SmartlinkControllerAdapter`
