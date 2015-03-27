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
    reset: ->
      @set 'state', 'idle'
      @set 'ms', 0
      @end = null
      @notifyPropertyChange 'timeUpdated'
      false
    timerEnd: ->
      @playNotification()
      @get('controllers.people').send('switchDriver')
      @send 'reset'
      clearTimeout(@timeout)
      false

  minutes: 15
  ms: 0
  state: 'idle'

  message: (->
    switch @get('state')
      when 'idle'
        if @get('driver')
          "Grab the keyboard #{@get('driver.name')}. Don't forget to change the keyboard language."
        else
          'Get ready for some mob programming.'
      when 'paused'
        'You deserve a break!'
      when 'running'
        "Time to write some code #{@get('driver.name')}! Try not to think too much."
  ).property('state', 'driver')

  driver: (->
    @get('controllers.people.currentDriver')
  ).property('controllers.people.currentDriver')

  running: (->
    @get('state') == 'running'
  ).property('state')

  paused: (->
    @get('state') == 'paused'
  ).property('state')

  msLeft: ->
    if @end
      @end.diff(moment(), 'milliseconds')
    else
      @get 'ms'

  timer: (->
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
