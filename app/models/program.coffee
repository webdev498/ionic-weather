`import DS from 'ember-data'`

Program = DS.Model.extend
  identifier:           DS.attr 'string', defaultValue: ''
  description:          DS.attr 'string'
  smartlinkController:  DS.belongsTo 'smartlinkController'

Program.reopenClass
  FIXTURES: [
    {
      id: 1
      identifier: 'a'
      description: 'This is Program A'
      smartlinkController: 1
    },
    {
      id: 2
      identifier: 'b'
      description: 'This is Program B'
      smartlinkController: 1
    },
    {
      id: 3
      identifier: 'c'
      description: 'This is Program C'
      smartlinkController: 1
    },
    {
      id: 4
      identifier: 'd'
      description: 'This is Program D'
      smartlinkController: 1
    },
    {
      id: 5
      identifier: 'a'
      description: 'This is Program A'
      smartlinkController: 2
    },
    {
      id: 6
      identifier: 'b'
      description: 'This is Program B'
      smartlinkController: 2
    },
    {
      id: 7
      identifier: 'c'
      description: 'This is Program C'
      smartlinkController: 2
    },
    {
      id: 8
      identifier: 'd'
      description: 'This is Program D'
      smartlinkController: 2
    },
    {
      id: 9
      identifier: 'a'
      description: 'This is Program A'
      smartlinkController: 3
    },
    {
      id: 10
      identifier: 'b'
      description: 'This is Program B'
      smartlinkController: 3
    },
    {
      id: 11
      identifier: 'c'
      description: 'This is Program C'
      smartlinkController: 3
    },
    {
      id: 12
      identifier: 'd'
      description: 'This is Program D'
      smartlinkController: 3
    },
    {
      id: 13
      identifier: 'a'
      description: 'This is Program A'
      smartlinkController: 4
    },
    {
      id: 14
      identifier: 'b'
      description: 'This is Program B'
      smartlinkController: 4
    },
    {
      id: 15
      identifier: 'c'
      description: 'This is Program C'
      smartlinkController: 4
    },
    {
      id: 16
      identifier: 'd'
      description: 'This is Program D'
      smartlinkController: 4
    },
    {
      id: 17
      identifier: 'a'
      description: 'This is Program A'
      smartlinkController: 5
    },
    {
      id: 18
      identifier: 'b'
      description: 'This is Program B'
      smartlinkController: 5
    },
    {
      id: 19
      identifier: 'c'
      description: 'This is Program C'
      smartlinkController: 5
    },
    {
      id: 20
      identifier: 'd'
      description: 'This is Program D'
      smartlinkController: 5
    },
    {
      id: 21
      identifier: 'a'
      description: 'This is Program A'
      smartlinkController: 6
    },
    {
      id: 22
      identifier: 'b'
      description: 'This is Program B'
      smartlinkController: 6
    },
    {
      id: 23
      identifier: 'c'
      description: 'This is Program C'
      smartlinkController: 6
    },
    {
      id: 24
      identifier: 'd'
      description: 'This is Program D'
      smartlinkController: 6
    }
  ]

`export default Program`
