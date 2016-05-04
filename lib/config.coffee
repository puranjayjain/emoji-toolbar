module.exports =
  preferredFormat:
    title: 'Preferred Output Format'
    type: 'string'
    default: 'name'
    enum: [
      {
        value: 'name'
        description: 'Foo mode. You want this.'
      }
      {
        value: 'unicode'
        description: 'Bar mode. Nobody wants that!'
      }
      {
        value: 'emoji'
        description: 'Bar msNobody wants that!'
      }
    ]
