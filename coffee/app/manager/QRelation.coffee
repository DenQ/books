class QRelation

  storage: null
  KEY: 'relation'

  constructor:(@storage)->
    unless @storage.get(@KEY)?
      @storage.set @KEY, []
