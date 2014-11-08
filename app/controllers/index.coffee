`import Ember from 'ember'`

IndexController = Ember.Controller.extend
  needs: ['people']

  actions:
    start: ->
      if @get('state') == 'idle'
        @end = moment().add(@get('minutes'), 'minutes')
      else
        @end = moment().add(@get('ms'))
      @set 'state', 'running'
      @tick()
      false
    pause: ->
      @set 'state', 'paused'
      @set 'ms', @msLeft()
      false
    timerEnd: ->
      @playNotification()
      @get('controllers.people').send('switchDriver')
      @set 'state', 'idle'
      @set 'ms', 0
      @end = null
      @notifyPropertyChange 'timeUpdated'
      clearTimeout(@timeout)
      false

  minutes: 15
  ms: 0
  state: 'idle'
  running: ( ->
    @get('state') == 'running'
  ).property('state')

  msLeft: ->
    if @end
      @end.diff(moment(), 'milliseconds')
    else
      @get 'ms'

  timer: ( ->
    moment(@msLeft()).format('mm:ss')
  ).property('timeUpdated')

  tick: ->
    @notifyPropertyChange 'timeUpdated' if @get('running')

    if @msLeft() <= 0
      @send('timerEnd')
    else if @get('running')
      @timeout = setTimeout ( =>
        @tick()
      ), 1000

  playNotification: ->
    notification = $('.notification')[0]
    notification.load()
    notification.play()

    $('.overlay').css(height: '100%')
    $('.overlay')
      .animate(opacity: 0.5, 400)
      .animate(opacity: 0, 200)
      .delay(200)
      .animate(opacity: 0.5, 400)
      .animate(opacity: 0, 200, ->
        $('.overlay').css(height: '0')
      )

`export default IndexController`
