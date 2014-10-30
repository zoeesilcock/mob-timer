`import DS from 'ember-data'`

Person = DS.Model.extend {
  name: DS.attr('string')
  currentDriver: DS.attr('boolean', default: false)
}

Person.reopenClass({ FIXTURES: [] })

`export default Person`
