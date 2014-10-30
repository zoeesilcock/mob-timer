`import Ember from 'ember'`

PeopleController = Ember.ArrayController.extend
  actions:
    addPerson: ->
      @store.createRecord 'person',
        name: @get 'name'
      @set 'name', ''
    shuffle: ->
      @set 'sortProperties', ['name']
      false
    nextDriver: ->
      nextIsDriver = false
      driverSet = false

      @get('arrangedContent').forEach (item) ->
        if item.get('currentDriver')
          item.set('currentDriver', false)
          nextIsDriver = true
        else if nextIsDriver
          item.set('currentDriver', true)
          nextIsDriver = false
          driverSet = true

      unless driverSet
        @get('firstObject').set('currentDriver', true)

  itemController: 'person'
  sortProperties: ['name']
  sortFunction: (a, b) ->
    0.5 - Math.random()

`export default PeopleController`
