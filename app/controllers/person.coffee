`import Ember from 'ember'`

PersonController = Ember.ObjectController.extend
  actions:
    remove: ->
      @model.deleteRecord()
  isDriver: (->
    @get('parentController.currentDriver') == @model
  ).property('parentController.currentDriver')

`export default PersonController`
