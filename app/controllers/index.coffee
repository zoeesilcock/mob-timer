`import Ember from 'ember'`

IndexController = Ember.Controller.extend
  actions:
    start: ->
      @end = moment().add(15, 'minutes')
      @tick()
      false
    stop: ->
      clearTimeout(@timeout)
      false

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
