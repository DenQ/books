$ ->

  qls = new QLocalStorage()
  QManager::SetStorage qls

  qList = new QList()
  qList.fill()


#  __id = 'book_5527d2a35505a'
#
#  book =
#    'author': 'a1',
#    'year': 'y1',
#    'title': 't1',
#    'countPages': 'cp1',
#  QManager::GetInstance().Create book
#
#  console.log QManager::GetInstance().Read __id
#
#  console.log QManager::GetInstance().GetRelation().getRelation()

#  book.title = 't1_new'
#  console.log QManager::GetInstance().Update __id, book
#
#  console.log QManager::GetInstance().Delete __id


  $('.btn-edit').click (e) ->
    T = $(e.currentTarget)
    __id = T.parents('tr:first').attr 'bid'
    row = QManager::GetInstance().Read __id
    $('#book-editor #author').val row.author
    $('#book-editor #year').val row.year
    $('#book-editor #title').val row.title
    $('#book-editor #numberPages').val row.countPages
    return


  $('.btn-remove').click (e) ->
    T = $(e.currentTarget)
    $tr = T.parents('tr:first')
    __id = $tr.attr 'bid'
    QManager::GetInstance().Delete __id
    $tr.remove()
    return


  return