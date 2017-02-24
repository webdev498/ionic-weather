`import DS from 'ember-data'`

EditLabels = DS.Model.extend
    number:              DS.attr 'number'
    title:               DS.attr 'string'
    description:         DS.attr 'string'
    active:              DS.attr 'boolean'

`export default Inspections`