`import Ember from 'ember'`
`import ManualRunMixin from '../../../../mixins/manual-run'`
`import Base from 'ember-simple-auth/authenticators/base'`
`import AuthenticationMixin from '../../../../mixins/authentication'`
`import AjaxMixin from '../../../../mixins/ajax'`
`import config from '../../../../config/environment'`

SmartlinkControllerSelectInspectionController = Ember.Controller.extend ManualRunMixin, AjaxMixin,
  session: Ember.inject.service()
  isEmailInspectionOpen: false
  actions:
    openEmailInspectionMenu: ->
      console.log("hi")
      @set('isEmailInspectionOpen', true)
    closeEmailInspectionMenu: ->
      @set('isEmailInspectionOpen', false)


`export default SmartlinkControllerSelectInspectionController`