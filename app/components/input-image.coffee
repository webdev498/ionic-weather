`import Ember from 'ember'`

InputImageComponent = Ember.TextField.extend(
  type: 'file'
  change: (evt) ->
    input = evt.target
    if input.files and input.files[0]
      that = this
      reader = new FileReader

      reader.onload = (e) ->
        data = e.target.result
        that.set 'fdata', data
        Ember.Logger.debug data

        #url = "#{@get('config.apiUrl')}/api/v2/controllers/8667/zones/#{zoneId}"
        url = " https://staging.smartlinknetwork.com/api/v2/controllers/8667/zones/324594"

        queryParams = { 
          timestamp: new Date().getTime(),
          photo: data
        }

        new Ember.RSVP.Promise (resolve, reject) ->
          Ember.$.ajax(url,
            type: 'PUT',
            data: queryParams
            success: (response) ->
              Ember.Logger.debug "Successfully submitted photo"
            error: (xhr, status, error) ->
              Ember.Logger.debug "Could not submit photo"
              Ember.Logger.debug status
              Ember.Logger.debug error
          )
        return

      reader.readAsDataURL input.files[0]
    return
)

`export default InputImageComponent`