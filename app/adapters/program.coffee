`import ApplicationAdapter from './application'`

ProgramAdapter = ApplicationAdapter.extend(
  ajaxOptions: (url, type, options) ->
    hash = this._super(arguments...)
    @addCustomParams(hash)
    return hash

  addCustomParams: (options) ->
    options.data = options.data or {}
    Ember.merge(options.data, {
      embed_program_seasonal_adjustments: true
    })
)

`export default ProgramAdapter`
