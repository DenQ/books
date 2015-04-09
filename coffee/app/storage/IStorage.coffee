class IStorage

  constructor:->
    @initStorage()

  initStorage:->
    throw false

  get:(key)->
    throw false

  set:(key, val)->
    throw false

  delete:(key)->
    throw false

  getStorage:->
    throw false