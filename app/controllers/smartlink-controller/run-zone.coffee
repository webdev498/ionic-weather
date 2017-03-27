`import Ember from 'ember'`
`import ManualRunMixin from '../../mixins/manual-run'`
`import leftPad from '../../util/strings/left-pad'`

SmartlinkControllerRunZoneController = Ember.Controller.extend ManualRunMixin,
  $scope = this;
  init: ->
    allMins = [1..59].map (num) ->
      {
        label: leftPad(2, num)
        value: num
      }

    fiveMinIntvls = []

    [0..55].forEach( (num) ->
      if num % 5 is 0
        fiveMinIntvls.push({
          label: leftPad(2, num)
          value: num
        })
    , this)

    availHrs = [0..9].map (num) ->
      {
        label: leftPad(2, num)
        value: num
      }

    @set('allMinutes', allMins)
    @set('fiveMinuteIntervals', fiveMinIntvls)

    @set('availableRunTimeHours', availHrs)
    @set('availableRunTimeMinutes', allMins)

  startCountdown: (min, display) ->
    if(@get('showTimer'))
      $(display).css('display','block')
      $('.weathermatic-content').css('bottom','50px');
      if (window.cordova) then StatusBar.overlaysWebView(true)
      start = Date.now()
      duration = min * 60

      stop = ->
        clearInterval($scope.countdown)
        $(display).html(' ').removeClass('close').css('display','none')
        if (window.cordova) then StatusBar.overlaysWebView(false)

      keepGoing = ->
        #get the number of seconds that have elapsed since
        #startCountdown() was called
        diff = duration - (((Date.now() - start) / 1000) | 0)

        #does the same job as parseInt truncates the float
        minutes = (diff / 60) | 0
        seconds = (diff % 60) | 0

        minutes = if (minutes < 10) then ("0" + minutes) else minutes
        seconds = if (seconds < 10) then ("0" + seconds) else seconds

        zone = if ($scope.zoneName) then $scope.zoneName + " (Zone " + $scope.zoneNumber + ")" else "Zone " + $scope.zoneNumber

        $(display).css('display','block').attr('href',$scope.zoneLink).html('<div>Running ' + zone + '<span> - '+minutes + ':' + seconds+'</span></div>')
        if (window.cordova) then StatusBar.overlaysWebView(true)

        #add one second so that the count down starts at the full duration
        #example 05:00 not 04:59

        if (diff <= 0) then stop()

      timer = ->
        if(!$('.statusBar').hasClass('close')) then keepGoing() else stop()

      #we don't want to wait a full second before the timer starts
      stop()
      timer()
      $scope.countdown = setInterval(timer, 1000)
    else
      $('.weathermatic-content').css('bottom','0px');
      $('.statusBar').addClass('close');

  runTimeHours: 0

  runTimeMinutes: 5

  minutesDidChange: Ember.observer 'runTimeMinutes', ->
    if parseInt(@get('runTimeHours')) is 0
      @set('previousRunTimeMinutesSelection', @get('runTimeMinutes'))

  hoursDidChange: Ember.observer 'runTimeHours', ->
    if parseInt(@get('runTimeHours')) >= 1
      @set('availableRunTimeMinutes', @get('fiveMinuteIntervals'))
      @set('runTimeMinutes', 0)
    else
      prevMin = @get('previousRunTimeMinutesSelection')
      @set('runTimeMinutes', prevMin) if prevMin
      @set('availableRunTimeMinutes', @allMinutes)

  # This is slightly weird, see: https://weathermatic.atlassian.net/browse/SM-42
  totalRunTimeMinutesConverted: Ember.computed 'runTimeHours', 'runTimeMinutes', ->
    hrs = parseInt(@get('runTimeHours'))
    mins = parseInt(@get('runTimeMinutes'))

    totalMins = (hrs * 60) + mins

    return totalMins if totalMins <= 60

    # For every 5 minutes over 1 hour, add 1 to the original 60 minutes
    #
    # This is what the backend will actually do:
    # --------------------------
    # INPUT      ACTUAL RUN TIME
    # --------------------------
    # 59 min  |  59 min
    # 60 min  |  1 hour
    # 61 min  |  1 hour, 5 min
    # 62 min  |  1 hour, 10 min
    # ...
    # 72 min  |  2 hours
    # --------------------------

    extraMins = totalMins - 60
    fiveMinIntvls = Math.floor(extraMins / 5)

    60 + fiveMinIntvls

  actions:
    runZone: (zoneName,zone) ->
      self = this
      $scope.zone = {}
      $scope.zone.name = zoneName
      $scope.zone.number = zone
      $scope.zone.href = location.hash
      @set('showTimer',true);
      params = {
        zone: @get('model.number')
        run_time: @get('totalRunTimeMinutesConverted')
      }
      @get('loadingModal').send('open')
      @submitManualRun(params).then (instruction) ->
        Ember.debug "Posted run zone: #{self.get('model.number')} \
          for controller: #{self.get('model.smartlinkController.id')}"
        self.get('loadingModal').send('loadInstruction', instruction)
      .catch (error) ->
        Ember.Logger.error(error)
        alert error
        self.get('loadingModal').send('close')

    loadingFinished: ->
      $scope.zoneName = $scope.zone.name;
      $scope.zoneNumber = $scope.zone.number;
      $scope.zoneLink = $scope.zone.href;
      this.startCountdown(this.runTimeMinutes,'.statusBar');
      Ember.run.later this, ->
        @get('loadingModal').send('close')
      , 750

    loadingAbandoned: ->
      $scope.zoneName = $scope.zone.name;
      $scope.zoneNumber = $scope.zone.number;
      $scope.zoneLink = $scope.zone.href;
      this.startCountdown(this.runTimeMinutes,'.statusBar');
      @get('loadingModal').send('close')

    stop: ->
      self = this
      params = {
        run_action: 'manual_stop_program'
      }
      @set('showTimer',false);
      @get('loadingModal').send('open')
      @submitManualRun(params).then (instruction) ->
        Ember.Logger.debug "Manual stop complete for controller #{self.get('model.smartlinkController.id')}"
        self.get('loadingModal').send('loadInstruction', instruction)
      .catch (error) ->
        Ember.Logger.error(error)
        alert error
        self.get('loadingModal').send('close')


`export default SmartlinkControllerRunZoneController`
