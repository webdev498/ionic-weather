import ApplicationAdapter from './application';

const { merge } = Ember;

const InspectionAdapter = ApplicationAdapter.extend({
    buildURL: function (type, id, snapshot) {
        //Let's get the current controller id
        var controller = this.get('store').peekAll('smartlinkController');
        var controllerId = 0;
        if(controller.objectAt(0)) {
            controllerId = controller.objectAt(0).id;
        }
        var url = this.host + '/' + this.namespace + '/controllers/' + controllerId + '/inspections';
        //If this is a request for the single inspection, our id will be defined
        if(id) {
            url += "/" + id;
        }
        return url;
    },

    ajaxOptions(url, type, options) {
        var hash = this._super(...arguments);
        //hash.data.timestamp = new Date().getTime();
        //debugger;
        //this.addCustomParams(hash);
        return hash;
    },
    addStandardParams(options) {
      options.data = options.data || {};
      return {
         timestamp: new Date().getTime()
      }
    },

    addCustomParams(options) {
        options.data = options.data || {};
        return {
            timestamp: new Date().getTime(),
        };
    },

    //Overriding the handleResponse from the application adapter as it seems inspections are a bit different
    handleResponse(status, _headers, json) {
        //  Weathermatic API responses are wrapped in an object called `result`, e.g.
        //
        //  {
        //    "result": {
        //      "site": { ... }
        //    },
        //    "meta": { ... }
        //  }
        //
        //  We want something like this instead:
        //  {
        //    "site": { ... },
        //    "meta": { ... }
        //  }
        //
        // For the inspection route, it returns:
        /* {
            "inspections": [
                "controller": 
            ]
        }
        */
        if (status !== 200) {
            throw new Error("InspectionAdapter.handleResponse() got non-success status code: ", status);
        }
        console.log("inspection returns: ");
        console.log(json);
        if(json.inspections) {
            for(var i = 0; i < json.inspections.length; i++) {
                var inspection = json.inspections[i];
                //Now, set the embedded inspection attrs
                inspection.inspector_id = inspection.inspector.id;
                inspection.inspector_name = inspection.inspector.name;
            }
             return json;
        }
        else {
            if(json.inspector) {
                json.inspector_name = json.inspector.name;
                json.inspector_id = json.inspector.id;
            }
            //In proper JSON API, a singular request is encased with the type
            return {inspection: json};
        }
    }
});

export default InspectionAdapter;
