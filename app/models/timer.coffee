`import DS from 'ember-data'`

Timer = DS.Model.extend {
  minutes: DS.attr('number')

  saveWhenDirty: (->
    @save() if @get('isDirty')
  ).observes('minutes')
}

`export default Timer`
