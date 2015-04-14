class ListHelper

  Size:->
    size = 0
    for x of localStorage
      size =+ (localStorage[x].length * 2 / 1024 / 1024)
    return size.toFixed(5)