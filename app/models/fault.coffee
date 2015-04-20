`import DS from 'ember-data'`

Fault = DS.Model.extend
  text:                 DS.attr('string')
  smartlinkController:  DS.belongsTo('smartlink-controller')

Fault.reopenClass
  FIXTURES: [
    { id: 1, text: 'something went horribly wrong', smartlinkController: 1 }
    { id: 2, text: 'something went horribly wrong', smartlinkController: 2 }
    { id: 3, text: 'aircard comm failure', smartlinkController: 2 }
  ]

`export default Fault`
