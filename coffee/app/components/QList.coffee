class QList

  getTemplate:->
    $('div#templates .table-tr tr').clone()

  fill:->
    Relations = QManager::GetInstance().GetRelation().getRelation()
    @pushItem(__id) for __id in Relations.reverse()


  pushItem:(__id)->
    row = QManager::GetInstance().Read __id
    $tr = @getTemplate()
    $tr.find('.author').text row.author
    $tr.find('.title').text row.title
    $tr.attr 'bid', __id
    $('.list-book tbody').append $tr


  empty:->
    $('.list-book tbody tr.item').remove()