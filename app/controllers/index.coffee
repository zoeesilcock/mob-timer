`import Ember from 'ember'`

IndexController = Ember.Controller.extend
  actions:
    start: ->
      @set 'running', true
      @end = moment().add(@get('minutes'), 'minutes')
      @tick()
      false
    stop: ->
      @set 'running', false
      clearTimeout(@timeout)
      false

  minutes: 15
  running: false

  timer: ( ->
    if @end
      timeLeft = @end.diff(moment(), 'milliseconds')
      moment(timeLeft).format('mm:ss')
  ).property('timeUpdated')

  tick: ->
    @notifyPropertyChange 'timeUpdated'

    @timeout = setTimeout ( =>
      @tick()
    ), 1000

`export default IndexController`
