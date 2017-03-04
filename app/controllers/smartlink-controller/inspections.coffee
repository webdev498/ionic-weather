`import Ember from 'ember'`
`import ManualRunMixin from '../../mixins/manual-run'`
`import Base from 'ember-simple-auth/authenticators/base'`
`import AuthenticationMixin from '../../mixins/authentication'`
`import AjaxMixin from '../../mixins/ajax'`
`import config from '../../config/environment'`

SmartlinkControllerInspectionsController = Ember.Controller.extend ManualRunMixin, AjaxMixin,

  needs: ['smartlinkController'],
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'
  
`export default SmartlinkControllerInspectionsController`