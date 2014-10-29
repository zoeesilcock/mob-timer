`import Ember from 'ember'`

IndexController = Ember.Controller.extend
  init: ->
    @now = moment()

  timer: ( ->
    moment('2014-10-30').toString()
  ).property('timeUpdated')

  tick: ->
    @notifyPropertyChange 'timeUpdated'

    setTimeout ( =>
      @tick()
    ), 1000

`export default IndexController`
