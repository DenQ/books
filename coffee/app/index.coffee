$ ->

  qls = new QLocalStorage()
  QManager::SetStorage qls

  QList::Fill()

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


  $('.list-book').on('click', '.btn-edit', (e) ->
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
    return null
  )

  $('.list-book').on('click', '.btn-remove', (e) ->
    T = $(e.currentTarget)
    $tr = T.parents('tr:first')
    __id = $tr.attr 'bid'
    QManager::GetInstance().Delete __id
    $tr.remove()
    return null
  )
  #  system btn
  $('.btn-reset').click (e) ->
    $('.btn-update').hide()
    $('.btn-create').show()
    $('.btn-update').removeAttr 'bid'
    null

  #  system btn
  $('.btn-create').click (e) ->
    T = $(e.currentTarget)
    __id = T.attr 'bid'
    QManager::GetInstance().Create FormHelper::GetJson()
    QList::Reload()
    null

  #  system btn
  $('.btn-update').click (e) ->
    T = $(e.currentTarget)
    __id = T.attr 'bid'
    QManager::GetInstance().Update __id, FormHelper::GetJson()
    QList::Reload()
    null


  return