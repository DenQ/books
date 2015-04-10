class QManager

  storage: null
  instance: null
  relation: null

  constructor:->
    unless @storage?
      throw false
    @relation = new QRelation @storage
    @

  SetStorage:(IStorage)->
    @storage = IStorage
    null

  GetInstance:->
    if @instance?
      return @instance
    else
      @instance = new @constructor()
      @instance


  Create:(json)->
    if __id = @relation.newRow()
      @storage.set __id, json
      return __id
    return false

  Read:(__id)->
    return @relation.findById __id


  Update:(__id, json) ->

  Delete:(__id)->
