class QValidation

  json:null
  scenario: null

  constructor:(@json, @scenario = 'create')->
    unless @json?
      throw 'Необходимо заполнить форму'
    @existsFields()
    @requireNumericFields()
    if @scenario is 'create'
      @uniqueFields()
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


  uniqueFields:->
    unless QManager::GetInstance().Search('title', @json.title) is null
      throw 'Книга с таким именем уже существует'
    return null