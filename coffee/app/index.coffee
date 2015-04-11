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
    if json = QManager::GetInstance().Read __id
      FormHelper::Set json
      $('.btn-update').show()
      $('.btn-create').hide()
      $('.btn-update').attr 'bid', __id
    return null
  )

  $('.list-book').on('click', '.btn-remove', (e) ->
    T = $(e.currentTarget)
    $tr = T.parents('tr:first')
    __id = $tr.attr 'bid'
    if QManager::GetInstance().Delete(__id) is true
#      $tr.remove()
      QList::Reload()
      if bid = $('.btn-update').attr('bid')
        FormHelper::Reset() if bid is __id
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
    if QManager::GetInstance().Create(FormHelper::GetJson()) isnt false
      QList::Reload()
    null

  #  system btn
  $('.btn-update').click (e) ->
    T = $(e.currentTarget)
    __id = T.attr 'bid'
    if QManager::GetInstance().Update(__id, FormHelper::GetJson()) is true
      QList::Reload()
    null


  return