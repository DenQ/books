class QRelation

  storage: null
  KEY: 'relation'

  constructor:(@storage)->
    unless @storage.get(@KEY)?
      @storage.set @KEY, []


  newRow:->
    __id = uniqid 'book_'
    relation = @storage.get @KEY
    relation = [] if not relation? or relation.length is 0
    relation = relation if relation.length isnt 0
    relation.push __id
    @storage.set @KEY, relation
    return __id

  findById:(__id)->
    if relation = @storage.get @KEY
      return __id in relation
    return false
