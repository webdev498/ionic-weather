import ApplicationAdapter from './application';

const { merge } = Ember;

const InspectionAdapter = ApplicationAdapter.extend({
    buildURL: function (type, id, snapshot) {
        //This is where the I am testing the API Url to figure out the inspections 
        return this.host + '/' + this.namespace + '/inspections';
    },

    ajaxOptions(url, type, options) {
        const hash = this._super(...arguments);
        this.addCustomParams(hash);
        return hash;
    },

    addCustomParams(options) {
        options.data = options.data || {};
        /*return Ember.merge(options.data, {
            embed_controller: true,
            controller_id: 8830
        }); */

        return {
            embed_controller: true,
            controller_id: 8830
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
        // MISSING: No inspections have an id, which ember needs. Will need to parse from a string or ask api to return it to us.
        if (status !== 200) {
            error("InspectionAdapter.handleResponse() got non-success status code: ", status);
        }
        console.log("inspection returns: ");
        console.log(json);
        //Since the inspection object is embedded, lets return it. There is no id in the reponse either
        for(var i = 0; i < json.inspections.length; i++) {
            var inspection = json.inspections[i];
            var href = inspection.inspection_href;
            //Parse the id from the end of the string
            var stringArr = href.split("/");
            var id = stringArr[stringArr.length - 1];
            if (id) {
                //Get the id from the embedded route
                inspection.id = id;
            }
            //Now, set the embedded inspection attrs
            inspection.inspector_id = inspection.inspector.id;
            inspection.inspector_name = inspection.inspector.name;
        }
        return json;
    }

});

export default InspectionAdapter;
