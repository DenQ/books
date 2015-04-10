$ ->



  qls = new QLocalStorage()
  QManager::SetStorage qls

  book =
    'author': 'a1',
    'year': 'y1',
    'title': 't1',
    'countPages': 'cp1',
  QManager::GetInstance().Create book
#  console.log QManager::GetInstance()
#  console.log QManager::GetInstance()
#  qls.set 'k1', 'v1'
#  console.log qls.get 'k1'
#  qls.delete 'k1'
#  console.log qls.getStorage()
#  $('.btn-edit').click (e) ->
#    console.log e
#    return
  return