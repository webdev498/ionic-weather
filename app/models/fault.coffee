`import DS from 'ember-data'`

Fault = DS.Model.extend
  description:          DS.attr('string')
  smartlinkController:  DS.belongsTo('smartlink-controller')

`export default Fault`
