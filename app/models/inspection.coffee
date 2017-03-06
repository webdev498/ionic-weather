`import DS from 'ember-data'`

Inspection = DS.Model.extend
  title:              DS.attr 'string'
  inspection_href:    DS.attr 'string'
  creatd_at:          DS.attr 'string'
  date:               DS.attr 'string'
  inspector_id:       DS.attr 'string'
  inspector_name:     DS.attr 'string'

  smartlinkController: DS.belongsTo 'smartlinkController', async: true

`export default Inspection`