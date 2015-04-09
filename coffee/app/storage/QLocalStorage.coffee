class QLocalStorage extends IStorage

  storage: null

  initStorage:->
    try
      @storage = localStorage
    catch error
      console.log error
    null

  getStorage:-> @storage

  get:(key)-> @storage.getItem key

  set:(key, val)->
    @storage.setItem key, val
    null

  delete:(key)->
    @storage.removeItem key
    null