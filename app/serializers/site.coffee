`import ApplicationSerializer from './application'`

SiteSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    smartlinkControllers:
      serialize: false
      deserialize: 'ids'

  keyForRelationship: (rawKey, kind) ->
    switch rawKey
      when 'smartlinkControllers' then 'controller_ids'
      else this._super(arguments...)

`export default SiteSerializer`
