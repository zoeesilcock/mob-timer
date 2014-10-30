`import Ember from 'ember'`

IndexRoute = Ember.Route.extend
  renderTemplate: (controller, model) ->
    @render()
    @render 'people',
      into: 'index'
      outlet: 'people'
      model: @store.find 'person'

`export default IndexRoute`
