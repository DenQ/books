do ->
  @uniqid = (pr, en) ->
    pr = pr or ""
    en = en or false
    result = undefined
    us = undefined
    @seed = (s, w) ->
      s = parseInt(s, 10).toString(16)
      (if w < s.length then s.slice(s.length - w) else (if (w > s.length) then new Array(1 + (w - s.length)).join("0") + s else s))

    result = pr + @seed(parseInt(new Date().getTime() / 1000, 10), 8) + @seed(Math.floor(Math.random() * 0x75bcd15) + 1, 5)
    result += (Math.random() * 10).toFixed(8).toString()  if en
    result