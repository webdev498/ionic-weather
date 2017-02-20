`import DS from 'ember-data'`

EditLabels = DS.Model.extend
    number:              DS.attr 'number'
    description:         DS.attr 'string'
    active:              DS.attr 'boolean'
    photo:               DS.attr 'string'
    photoThumbnail:      DS.attr 'string'

`export default EditLabels`
