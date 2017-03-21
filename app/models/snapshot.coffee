`import DS from 'ember-data'`

Snapshot = DS.Model.extend
  insp_programs:              DS.attr ''
  controller_omission_dates:  DS.attr ''
  controller_omission_days:   DS.attr ''
  controller_omission_times:  DS.attr ''

`export default Snapshot`