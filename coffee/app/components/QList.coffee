class QList

  GetTemplate:->
    return $('div#templates .table-tr tr').clone()

  Fill:->
    Relations = QManager::GetInstance().GetRelation().getRelation()
    @PushItem(__id) for __id in Relations.reverse()
    @CheckEmpty()
    return null


  PushItem:(__id)->
    row = QManager::GetInstance().Read __id
    $tr = @GetTemplate()
    $tr.find('.author').text row.author
    $tr.find('.title').text row.title
    $tr.attr 'bid', __id
    $('.list-book tbody').append $tr
    return null


  Empty:->
    $('.list-book tbody tr.item').remove()
    return null

  Reload:->
    @Empty()
    @Fill()
    FormHelper::Reset()
    @CheckEmpty()
    return null


  CheckEmpty:->
    if QManager::GetInstance().Count() is 0
      $('.empty-list').show()
    else
      $('.empty-list').hide()
    return null