class QLocalStorage extends IStorage

  storage: null

  initStorage:->
    try
      @storage = localStorage
    catch error
      console.log error
    null

  getStorage:-> @storage

  get:(key)-> JSON.parse @storage.getItem key

  set:(key, val)->
    @storage.setItem key, JSON.stringify val
    null

  delete:(key)->
    @storage.removeItem key
    null
