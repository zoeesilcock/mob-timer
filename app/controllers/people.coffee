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

  sortProperties: ['name']
  sortFunction: (a, b) ->
    0.5 - Math.random()

`export default PeopleController`
