`import ApplicationAdapter from './application'`
`import CurrentUserMixin from './../mixins/current-user'`

SmartlinkControllerAdapter = ApplicationAdapter.extend CurrentUserMixin,
  pathForType: -> 'controllers'

  ajaxOptions: (url, type, options) ->
    Ember.Logger.debug("SmartlinkControllerAdapter.ajaxOptions(), url, type, options", url, type, options)
    hash = this._super(arguments...) || { data: {} }
    Ember.merge(hash.data, this.customQueryParams)
    return hash

  find: (store, type, id, snapshot) ->
    Ember.Logger.debug('SmartlinkControllerAdapter.find(), type:, id:', type, id)
    url = @buildURL(type.typeKey, id, snapshot)
    @ajax(url, 'GET', data: @customQueryParams)

  findHasMany: (store, snapshot, url, relationship) ->
    switch relationship.key
      when 'instructions'
        @findInstructions(arguments...)
      when 'zones'
        @findZones(arguments...)
      when 'programs'
        @findPrograms(arguments...)
      else this._super(arguments...)

  findInstructions: (store, snapshot, url, relationship) ->
    extraParams = {
      embed_controller: false
      hide_admin_instructions: not @get('isLoggedInAsAdmin')
      hide_overnight_instructions: true
      datetime_format: '%b %d %l:%M %P (%Z)'
    }
    @findHasManyWithExtraParams(store, snapshot, url, relationship, extraParams)

  findZones: (store, snapshot, url, relationship) ->
    extraParams = {
      embed_program_zones: true
    }
    @findHasManyWithExtraParams(store, snapshot, url, relationship, extraParams)

  findPrograms: (store, snapshot, url, relationship) ->
    extraParams = {
      embed_program_seasonal_adjustments: 'true'
    }
    @findHasManyWithExtraParams(store, snapshot, url, relationship, extraParams)

  customQueryParams:
    embed_site: 'false'
    embed_controller_omission_days: 'true'
    embed_controller_omission_dates: 'true'
    embed_controller_omission_times: 'true'
    embed_program_seasonal_adjustments: 'true'

`export default SmartlinkControllerAdapter`
