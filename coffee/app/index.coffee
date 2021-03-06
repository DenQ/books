$ ->

  qls = new QLocalStorage()
  QManager::SetStorage qls

  QList::Fill()
  FormHelper::PrintInfo()

  $('.list-book').on('click', '.btn-edit', (e) ->
    T = $(e.currentTarget)
    $tr = T.parents('tr:first')
    __id = $tr.attr 'bid'
    if json = QManager::GetInstance().Read __id
      FormHelper::Set json
      $('.btn-update').show()
      $('.btn-create').hide()
      $('.btn-update').attr 'bid', __id
      FormHelper::PrintInfo()
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
        FormHelper::PrintInfo()
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

  resize = (e) ->
    MIN_WIDTH = 400
    if $('aside').position().left is 0
      $('aside').css 'width', '100%'
      $('section').css 'width', '100%'
    if $(document).width() >= MIN_WIDTH * 2
      $('aside').css 'width', '50%'
      $('section').css 'width', '50%'
    buttons()
    return null


  buttons =() ->
    MIN_WIDTH = 600
    if $(document).width() <= MIN_WIDTH * 2 * ($('aside').position().left isnt 0)
      $('form button').addClass 'btn-xs'
    else
      $('form button').removeClass 'btn-xs'
    null

  buttons()

  $(window).resize (e) ->
    resize e
    return null

  $(window).on "orientationchange", (e)->
    resize e
    return null

  $('.ui-loader-default').hide()

  return