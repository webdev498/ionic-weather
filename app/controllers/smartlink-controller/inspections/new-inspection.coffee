`import Ember from 'ember'`

SmartlinkControllerNewInspectionController = Ember.Controller.extend
  needs: ['smartlinkController']
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'
  init: () ->
    this.inspection_type = 0
  actions:
    onSelectEntityType: (value) ->
      this.inspection_type = value
      console.log(this.inspection_type)
    submission: (title, date, time, scheduleSelect)->
      formData = new FormData(document.querySelector("form"))
      console.log(formData.get('name'))
      console.log(title);
      console.log(date);
      console.log(time);
      combinedDateTime = date + "T" + time
      console.log(combinedDateTime);
      inspection = this.get('store').createRecord('inspection', 
      {
        title: title,
        date: combinedDateTime,
        inspection_type: this.inspection_type
      })
      inspection.save()


`export default SmartlinkControllerNewInspectionController`
