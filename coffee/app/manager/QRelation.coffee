class QRelation

  storage: null
  KEY: 'relation'

  constructor:(@storage)->
    unless @storage.get(@KEY)?
      @storage.set @KEY, []

  getRelation:->
    relation = @storage.get @KEY
    relation = [] if not relation? or relation.length is 0
    relation = relation if relation.length isnt 0
    return relation

  newRow:->
    __id = uniqid 'book_'
    relation = @getRelation()
    relation.push __id
    @storage.set @KEY, relation
    return __id

  findById:(__id)->
    if relation = @storage.get @KEY
      return __id in relation
    return false

  remove:(__id)->
    if @findById(__id) is true
      relation = @getRelation()
      __relation = []
      for item in relation
        if item isnt __id
          __relation.push item
      @storage.set @KEY, __relation
      return true
    return false