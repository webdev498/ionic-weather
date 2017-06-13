import Ember from 'ember';

const { Component } = Ember;
//anytime we add a language, add it here!!!
const installedLanguages = ['en','es','zh'];

const LogoHeaderComponent = Component.extend({
    i18n: Ember.inject.service(),

    languageIsInstalled: function(language){
      return installedLanguages.includes(language)
    },

    loadLanguage: function(language){
        let globalLanguage = language.split("-")[0];
        let languageExist = this.languageIsInstalled(globalLanguage);
        if(languageExist){
          this.set('i18n.locale', globalLanguage);
        }else{
          this.set('i18n.locale', 'en');
        }
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
      //for testing
      //this.set('i18n.locale', 'zh');
      this.setLanguage();
    }
});

export default LogoHeaderComponent;
