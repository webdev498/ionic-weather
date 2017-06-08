import Ember from 'ember';

const { Component } = Ember;

const LogoHeaderComponent = Component.extend({
    i18n: Ember.inject.service(),
    loadLanguage: function(language){
        let globalLanguage = language.split("-")[0];
        this.set('i18n.locale', globalLanguage);
    },
    setLanguage: function(){
        let self = this;
        if(navigator.globalization){
            navigator.globalization.getPreferredLanguage(
                function (language) {
                  self.loadLanguage(language.value);
                },
                function () {
                  this.set('i18n.locale', 'en');
                }
            );
        }
        else if(navigator.language){
          self.loadLanguage(navigator.language);
        }
    },
    init() {
      this._super(...arguments);
      //this.set('i18n.locale', 'zh');
      this.setLanguage();
    }
});

export default LogoHeaderComponent;
