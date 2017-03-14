`import DS from 'ember-data'`

Inspection = DS.Model.extend
  title:              DS.attr 'string'
  controller:         DS.attr ''
  created_at:          DS.attr 'string'
  date:               DS.attr 'string'
  inspector_id:       DS.attr 'string'
  inspector_name:     DS.attr 'string'
  inspection_type:    DS.attr 'number'
  inspections_zones:   DS.attr ''
  is_first_inspection: DS.attr 'boolean'
  prior_configuration_compliant: DS.attr 'boolean'
  prior_configuration_rf_present: DS.attr 'boolean'
  prior_equipment: DS.attr 'string'
  water_pressure:  DS.attr 'number'
  # Currently seems to be returning 0..
  water_pressure_unit: DS.attr 'string'


smartlinkController: DS.belongsTo 'smartlinkController', async: true
`export default Inspection`