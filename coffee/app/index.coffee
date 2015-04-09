$ ->
  qLocalStorage = new QLocalStorage()
  qLocalStorage.set 'k1', 'v1'
  console.log qLocalStorage.get 'k1'
  qLocalStorage.delete 'k1'
  console.log qLocalStorage.getStorage()
#  $('.btn-edit').click (e) ->
#    console.log e
#    return
  return