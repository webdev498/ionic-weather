import ApplicationAdapter from './application';

const { merge } = Ember;

const InspectionAdapter = ApplicationAdapter.extend({
    buildURL: function (type, id, snapshot) {
        //Let's get the current controller id
        var controller = this.get('store').peekAll('smartlinkController');
        var id = 0;
        if(controller.objectAt(0)) {
            id = controller.objectAt(0).id;
        }
        return this.host + '/' + this.namespace + '/controllers/' + id + '/inspections';
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
            error("InspectionAdapter.handleResponse() got non-success status code: ", status);
        }
        console.log("inspection returns: ");
        console.log(json);
        for(var i = 0; i < json.inspections.length; i++) {
            var inspection = json.inspections[i];
            //Now, set the embedded inspection attrs
            inspection.inspector_id = inspection.inspector.id;
            inspection.inspector_name = inspection.inspector.name;
        }
        return json;
    }

});

export default InspectionAdapter;
