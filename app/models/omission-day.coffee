`import DS from 'ember-data'`

OmissionDay = DS.Model.extend {
  day:                    DS.attr 'number'
  smartlinkController:    DS.belongsTo 'smartlink-controller'
}

`export default OmissionDay`
