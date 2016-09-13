import Ember from 'ember';

const { Mixin, computed , inject: { service }} = Ember;

const CurrentUserMixin = Mixin.create({

  session: service(),

  currentUser: computed('session', function() {
    return this.get('session.data.authenticated.userInfo.result.user');
  }),

  isLoggedInAsAdmin: computed('currentUser', function() {
    return this.get('currentUser.is_admin');
  })

});

export default CurrentUserMixin;
