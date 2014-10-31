`import Ember from 'ember'`

PersonController = Ember.ObjectController.extend
  isDriver: (->
    @get('parentController.currentDriver') == @model
  ).property('parentController.currentDriver')

`export default PersonController`
