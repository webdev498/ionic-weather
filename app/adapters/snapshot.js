import ApplicationAdapter from './application';

const { merge } = Ember;

const SnapshotAdapter = ApplicationAdapter.extend({
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
            url += ("/" + id + "/snapshot");
        }
        return url;
    },

    ajaxOptions(url, type, options) {
        const hash = this._super(...arguments);
        this.addCustomParams(hash);
        return hash;
    },

    addCustomParams(options) {
        options.data = options.data || {};
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
        console.log("snapshot returns: ");
        console.log(json);
        var retObj = json.snapshot;
        retObj.id = 100;
        retObj.insp_programs = retObj.programs;
        retObj.insp_zones = retObj.zones;
        delete retObj.programs;
        delete retObj.zones;
        console.log(retObj);
        return json;
    }
});

export default SnapshotAdapter;
