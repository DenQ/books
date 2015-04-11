class QManager

  storage: null
  instance: null
  relation: null

  constructor:->
    unless @storage?
      throw false
    @relation = new QRelation @storage
    @


  GetRelation:-> @relation

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
    if @Validation(json) is true
      if __id = @relation.newRow()
        @storage.set __id, json
        return __id
    return false


  Read:(__id)->
    if @relation.findById(__id) is true
      return @storage.get __id
    return false


  Update:(__id, json) ->
    if @relation.findById(__id) is false
      throw false
    if row = @Read __id
      if @Validation(json, 'update') is true
        @storage.set __id, json
        return true
    return false


  Delete:(__id)->
    if @relation.findById(__id) is true and row = @Read(__id)
      if @relation.remove(__id) is true
        @storage.delete __id
        return true
      return false
    return false


  Validation:(json, scenario)->
    try
      new QValidation json, scenario
      return true
    catch e
      alert e
      return false


  Count:->
    return @relation.getCount()


  Search:(key, val)->
    unless @Count() > 0
      return null
    for item in @relation.getRelation()
      if row = @Read item
        if row[key] is val
          return item
    return null
