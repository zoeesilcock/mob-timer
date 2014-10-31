`import DS from 'ember-data'`

Person = DS.Model.extend {
  name: DS.attr('string')
}

Person.reopenClass({ FIXTURES: [] })

`export default Person`
