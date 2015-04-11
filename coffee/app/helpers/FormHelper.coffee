class FormHelper

  SetValue:(field, row)->
    $('#book-editor #' + field).val row[field]


  GetValue:(field)->
    $('#book-editor #' + field).val()

  GetJson:->
    'author': @GetValue 'author'
    'year': @GetValue 'year'
    'title': @GetValue 'title'
    'countPages': @GetValue 'countPages'

  Reset:->
    $('.btn-reset').trigger 'click'
    null