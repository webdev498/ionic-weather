`import Ember from 'ember'`

SmartlinkControllerNewInspectionController = Ember.Controller.extend
  needs: ['smartlinkController']
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'
  actions:
    onSelectEntityType: (value) ->
      console.log(value)
    submission: (title, date, time, scheduleSelect)->
      formData = new FormData(document.querySelector("form"))
      console.log(formData.get('name'))
      console.log(title);
      console.log(date);
      console.log(time);
      console.log(scheduleSelect);

`export default SmartlinkControllerNewInspectionController`
