class QValidation

  json:null

  constructor:(@json)->
    unless @json?
      throw 'Необходимо заполнить форму'
    @existsFields()
    @requireNumericFields()
    return @


  existsFields:->
    unless @json.author? and @json.author.length > 0
      throw 'Необходимо указать автора'
    unless @json.title? and @json.title.length > 0
      throw 'Необходимо указать название'
    unless @json.year? and @json.year.length > 0
      throw 'Необходимо указать год'
    unless @json.countPages? and @json.countPages.length > 0
      throw 'Необходимо указать количество страниц'
    return null


  requireNumericFields:->
    unless isInt(@json.year) is true
      throw 'Поле "год", должно состоять только из цифр'
    unless isInt(@json.countPages) is true
      throw 'Поле "Количество страниц", должно состоять только из цифр'
    return null