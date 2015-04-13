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
    try
      @storage.setItem key, JSON.stringify val
    catch e
#      QUOTA_EXCEEDED_ERR
      NotifyHelper::Danger "Превышен лимит использования памяти localStorage"
    null

  delete:(key)->
    @storage.removeItem key
    null
