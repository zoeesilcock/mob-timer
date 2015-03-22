`import Ember from 'ember'`

PeopleController = Ember.ArrayController.extend
  needs: ['index']

  currentDriverIndex: 0
  currentDriver: (->
    @get('arrangedContent').objectAt(@get('currentDriverIndex'))
  ).property('currentDriverIndex', 'arrangedContent.@each')

  actions:
    addPerson: ->
      @store.createRecord('person',
        name: @get 'name'
      ).save()
      @set 'name', ''
    shuffle: ->
      @set 'sortProperties', ['name']
      @set 'currentDriverIndex', 0
      false
    switchDriver: ->
      @incrementProperty('currentDriverIndex')
      @set('currentDriverIndex', 0) if @currentDriverIndex >= @get('arrangedContent.length')

  itemController: 'person'
  sortProperties: ['name']
  sortFunction: (a, b) ->
    0.5 - Math.random()

`export default PeopleController`
