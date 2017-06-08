import Ember from 'ember';
import promisedProperty from '../util/promised-property';
import { translationMacro as t } from "ember-i18n";

const SitesController = Ember.Controller.extend({

    i18n: Ember.inject.service(),

    faults: t("user.edit.title"),

    init: function () {
        Ember.run.scheduleOnce('afterRender', this, function() {
            this.send('afterRender');
        });
    },

    actions: {
        afterRender: function(){
            console.log(this.get('i18n').t("sites.faultUnit").string)
        }
    }
})

export default SitesController
