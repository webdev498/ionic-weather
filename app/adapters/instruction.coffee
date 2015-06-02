`import ApplicationAdapter from './application'`

InstructionAdapter = ApplicationAdapter.extend
  ajaxOptions: (url, type, options) ->
    hash = this._super(arguments...)
    @addCustomParams(hash)
    return hash

  addCustomParams: (options) ->
    options.data = options.data or {}
    Ember.merge(options.data, {
      embed_controller: false
    })


`export default InstructionAdapter`
