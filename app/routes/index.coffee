`import Ember from 'ember'`

IndexRoute = Ember.Route.extend
  model: ->
    @store.find 'person'

`export default IndexRoute`
