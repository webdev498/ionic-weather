import Ember from 'ember';
import Pretender from 'pretender';
import SITES from './fixtures/sites';

var defaultHeaders = {
  'Content-Type': 'application/json'
};

var MockApi = Ember.Object.create({
  serve: function() {

    new Pretender(function() {

      this.get('api/v2/sites', function() {
        var response = JSON.stringify({
          result: {
            sites: SITES
          }
        });

        return [200, defaultHeaders, response];
      });

      this.get('api/v2/sites/:id', function(request) {
        var site;
        for (var i=0; i < SITES.length; i++) {
          if (SITES[i].id === request.params.id) {
            site = SITES[i];
            break;
          }
        }

        var response = JSON.stringify({
          result: {
            site: site
          }
        });

        return [200, defaultHeaders, response];
      });

    });
  }
});

export default MockApi;
