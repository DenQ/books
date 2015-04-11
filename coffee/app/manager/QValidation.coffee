class QValidation

  json:null

  constructor:(@json)->
    unless @json?
      throw 'Необходимо заполнить форму'
    @existsFields()
    return @


  existsFields:->
    unless @json.author? and @json.author.length > 0
      throw 'Необходимо указать автора'
    unless @json.title? and @json.title.length > 0
      throw 'Необходимо указать название'
    unless @json.year? and @json.year.length > 0
      throw 'Необходимо указать год'
    unless @json.countPages? and @json.countPages.length > 0
      throw 'Необходимо количество страниц'