`import ApplicationAdapter from './application'`

SitesAdapter = ApplicationAdapter.extend
  ajaxOptions: (url, type, options) ->
    options = options || {}
    options.data = options.data || {}

    extraQueryParams = {
      embed: false,
      include_links: false,
      include_permissions: false
    }

    Ember.merge(options.data, extraQueryParams)
    this._super(url, type, options)

`export default SitesAdapter`
