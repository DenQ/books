$ ->

  qls = new QLocalStorage()
  QManager::SetStorage qls

  Relations = QManager::GetInstance().GetRelation().getRelation()
  for __id in Relations.reverse()
    row = QManager::GetInstance().Read __id
    $tr = $('div#templates .table-tr tr').clone()
    $tr.find('.author').text row.author
    $tr.find('.title').text row.title
    $tr.attr 'bid', __id
    $('.list-book tbody').append $tr


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


#  $('.btn-edit').click (e) ->
#    console.log e
#    return
  return