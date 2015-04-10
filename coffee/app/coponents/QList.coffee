class QList

  push:(__id)->
    if row = QManager::GetInstance().Read(__id)
      return true
    return false

