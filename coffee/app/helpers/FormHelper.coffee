class FormHelper

  SetValue:(key, val)->
    $field = $('#book-editor #' + key)
    if $field.length > 0
      $field.val val
    return null


  GetValue:(field)->
    return $('#book-editor #' + field).val()


  GetJson:->
    'author': @GetValue 'author'
    'year': @GetValue 'year'
    'title': @GetValue 'title'
    'countPages': @GetValue 'countPages'


  Reset:->
    $('.btn-reset').trigger 'click'
    @PrintInfo()
    return null


  Set:(json)->
    for key, val of json
      @SetValue key, val
    return null


  PrintInfo:->
    memorySize = ListHelper::Size()
    countPages = QManager::GetInstance().Count()
    $('.total-memory').text memorySize
    $('.total-books').text countPages