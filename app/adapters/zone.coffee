`import ApplicationAdapter from './application'`

ZoneAdapter = ApplicationAdapter.extend(
  ajaxOptions: (url, type, options) ->
    hash = this._super(arguments...)
    @addCustomParams(hash)
    return hash

  addCustomParams: (options) ->
    options.data = options.data or {}
    Ember.merge(options.data, {
      embed_program_zones: true
    })
)

`export default ZoneAdapter`
