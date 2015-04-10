$ ->



  qls = new QLocalStorage()
  QManager::SetStorage qls

  __id = 'book_5527cdf680ffe'

  book =
    'author': 'a1',
    'year': 'y1',
    'title': 't1',
    'countPages': 'cp1',
  QManager::GetInstance().Create book

  console.log QManager::GetInstance().Read __id

  book.title = 't1_new'
  console.log QManager::GetInstance().Update __id, book

  console.log QManager::GetInstance().Delete __id


#  $('.btn-edit').click (e) ->
#    console.log e
#    return
  return