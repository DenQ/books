$ ->

  qls = new QLocalStorage()
  QManager::SetStorage qls

  QList::Fill()

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
    if confirm('Точно удалить?') is true
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
      FormHelper::Reset()
    null

  #  system btn
  $('.btn-update').click (e) ->
    T = $(e.currentTarget)
    __id = T.attr 'bid'
    if QManager::GetInstance().Update(__id, FormHelper::GetJson()) is true
      QList::Reload()
    null


  return