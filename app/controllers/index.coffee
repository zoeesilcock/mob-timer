`import Ember from 'ember'`

IndexController = Ember.Controller.extend
  needs: ['people']

  actions:
    start: ->
      @end = moment().add(@get('minutes'), 'minutes')
      @set 'running', true
      @tick()
      false
    timerEnd: ->
      @get('controllers.people').send('switchDriver')
      @set 'running', false
      clearTimeout(@timeout)
    stop: ->
      @set 'running', false
      clearTimeout(@timeout)
      false

  minutes: 15
  running: false

  msLeft: ->
    if @get('running')
      @end.diff(moment(), 'milliseconds')
    else
      0

  timer: ( ->
    moment(@msLeft()).format('mm:ss')
  ).property('timeUpdated')

  tick: ->
    @notifyPropertyChange 'timeUpdated'

    if @msLeft() <= 0
      @send('timerEnd')
    else
      @timeout = setTimeout ( =>
        @tick()
      ), 1000

`export default IndexController`
