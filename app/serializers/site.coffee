`import ApplicationSerializer from './application'`

SiteSerializer = ApplicationSerializer.extend({
  normalizeLinks: (data) ->
    data.links.smartlinkControllers = data.links.controllers
    delete data.links.controllers
    this._super(arguments...)

  keyForRelationship: (rawKey, kind) ->
    switch rawKey
      when 'smartlinkControllers' then 'controller_ids'
      else this._super(arguments...)
})

`export default SiteSerializer`
