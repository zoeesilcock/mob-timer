`import Ember from 'ember'`

PeopleController = Ember.ArrayController.extend
  actions:
    addPerson: ->
      @store.createRecord 'person',
        name: @get 'name'
      @set 'name', ''

`export default PeopleController`
