import Ember from 'ember';

const StringsMixin = Ember.Mixin.create({

  shorten: function(text, size) {
    if (size == null) {
      size = 30;
    }
    if (!(text != null ? text.length : void 0)) {
      return '';
    }
    if (this.strip(text).length >= size) {
      return (this.strip(text).substring(0, size)) + "...";
    } else {
      return text;
    }
  },

  strip: function(text) {
    return text != null ? text.replace(/^\s+|\s+$/g, '') : void 0;
  }

});

export default StringsMixin;
