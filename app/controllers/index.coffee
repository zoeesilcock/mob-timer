`import Ember from 'ember'`

IndexController = Ember.Controller.extend
  needs: ['people']

  actions:
    start: ->
      @set 'running', true
      @get('controllers.people').send('start')

      @end = moment().add(@get('minutes'), 'minutes')
      @tick()
      false
    nextDriver: ->
      @set 'running', false
      @get('controllers.people').send('nextDriver')

      clearTimeout(@timeout)
    stop: ->
      @set 'running', false
      clearTimeout(@timeout)
      false

  minutes: 15
  running: false

  msLeft: ->
    if @end
      @end.diff(moment(), 'milliseconds')

  timer: ( ->
    moment(@msLeft()).format('mm:ss')
  ).property('timeUpdated')

  tick: ->
    @notifyPropertyChange 'timeUpdated'

    if @msLeft() <= 0
      @send('nextDriver')
    else
      @timeout = setTimeout ( =>
        @tick()
      ), 1000

`export default IndexController`
