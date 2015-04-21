`import DS from 'ember-data'`

Zone = DS.Model.extend
  number: DS.attr 'number'
  description: DS.attr 'string'

  smartlinkController: DS.belongsTo 'smartlinkController'

Zone.reopenClass
  FIXTURES: [
    { id: 1, number: 1, description: 'Flower beds', smartlinkController: 1 }
    { id: 2, number: 2, description: 'Tree sculpture', smartlinkController: 1 }
    { id: 3, number: 3, description: 'Front lawn', smartlinkController: 1 }
    { id: 4, number: 1, description: 'Back lawn', smartlinkController: 2 }
    { id: 5, number: 2, description: 'Side lawn', smartlinkController: 2 }
    { id: 6, number: 3, description: 'Trees', smartlinkController: 2 }
    { id: 7, number: 1, description: 'Bushes', smartlinkController: 3 }
    { id: 8, number: 2, description: 'Shrubs', smartlinkController: 3 }
    { id: 9, number: 3, description: '', smartlinkController: 3 }
    { id: 10, number: 1, description: '', smartlinkController: 4 }
    { id: 11, number: 2, description: '', smartlinkController: 4 }
    { id: 12, number: 3, description: '', smartlinkController: 4 }
    { id: 13, number: 1, description: '', smartlinkController: 5 }
    { id: 14, number: 2, description: '', smartlinkController: 5 }
    { id: 15, number: 3, description: '', smartlinkController: 5 }
    { id: 16, number: 1, description: '', smartlinkController: 6 }
    { id: 17, number: 2, description: '', smartlinkController: 6 }
    { id: 18, number: 3, description: '', smartlinkController: 6 }
  ]

`export default Zone`
