`import Ember from 'ember'`

IndexRoute = Ember.Route.extend
  model: ->
    @store.find('timer', 1).then null, =>
      model = @store.createRecord 'timer', id: 1, minutes: 15
      model.save()

  renderTemplate: (controller, model) ->
    @render()
    @render 'people',
      into: 'index'
      outlet: 'people'
      model: @store.find 'person'

`export default IndexRoute`
