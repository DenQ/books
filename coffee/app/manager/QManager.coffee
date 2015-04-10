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
    id = uniqid('book_')
    @storage.set id, json

    relation = @storage.get 'relation'
    relation = [] if not relation? or relation.length is 0
    relation = relation if relation.length isnt 0
    relation.push id
    @storage.set 'relation', relation

  Read:(__id)->

  Update:(__id, json) ->

  Delete:(__id)->
