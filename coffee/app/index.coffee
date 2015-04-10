$ ->



  qls = new QLocalStorage()
  QManager::SetStorage qls

  book =
    'author': 'a1',
    'year': 'y1',
    'title': 't1',
    'countPages': 'cp1',
  QManager::GetInstance().Create book

  console.log QManager::GetInstance().Read 'book_5527b1afb40b0'

  book.title = 't1_new'
  console.log QManager::GetInstance().Update 'book_5527b1afb40b0', book


#  $('.btn-edit').click (e) ->
#    console.log e
#    return
  return