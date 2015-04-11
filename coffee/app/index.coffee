$ ->

  qls = new QLocalStorage()
  QManager::SetStorage qls

  qList = new QList()
  qList.fill()


#  __id = 'book_5527d2a35505a'

#  bid = uniqid()
#  book =
#    'author': "author #{bid}"
#    'year': "year #{bid}"
#    'title': "title #{bid}"
#    'countPages': "countPAges #{bid}"
#  QManager::GetInstance().Create book

#  console.log QManager::GetInstance().Read __id
#
#  console.log QManager::GetInstance().GetRelation().getRelation()

#  book.title = 't1_new'
#  console.log QManager::GetInstance().Update __id, book
#
#  console.log QManager::GetInstance().Delete __id


  $('.btn-edit').click (e) ->
    T = $(e.currentTarget)
    $tr = T.parents('tr:first')
    __id = $tr.attr 'bid'
    row = QManager::GetInstance().Read __id
    FormHelper::SetValue 'author', row
    FormHelper::SetValue 'year', row
    FormHelper::SetValue 'title', row
    FormHelper::SetValue 'countPages', row
    $('.btn-update').show()
    $('.btn-create').hide()
    $('.btn-update').attr 'bid', __id
    return


  $('.btn-remove').click (e) ->
    T = $(e.currentTarget)
    $tr = T.parents('tr:first')
    __id = $tr.attr 'bid'
    QManager::GetInstance().Delete __id
    $tr.remove()
    return

  $('.btn-reset').click (e) ->
    $('.btn-update').hide()
    $('.btn-create').show()
    $('.btn-update').removeAttr 'bid'
    null


  $('.btn-create').click (e) ->
    T = $(e.currentTarget)
    __id = T.attr 'bid'
    QManager::GetInstance().Create FormHelper::GetJson()
    qList = new QList()
    #todo : Поставить native bind для localStorage
    qList.empty()
    qList.fill()
    FormHelper::Reset()
    null


  $('.btn-update').click (e) ->
    T = $(e.currentTarget)
    __id = T.attr 'bid'
    QManager::GetInstance().Update __id, FormHelper::GetJson()
    qList = new QList()
    #todo : Поставить native bind для localStorage
    qList.empty()
    qList.fill()
    FormHelper::Reset()
    null


  return