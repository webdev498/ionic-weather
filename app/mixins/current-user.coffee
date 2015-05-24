`import Ember from 'ember'`

CurrentUserMixin = Ember.Mixin.create
  session: Ember.computed -> @container.lookup('simple-auth-session:main')

  currentUser: Ember.computed 'session', ->
    @get('session.secure.userInfo.result.user')

  isLoggedInAsAdmin: Ember.computed 'currentUser', ->
    @get('currentUser.is_admin')

`export default CurrentUserMixin`
