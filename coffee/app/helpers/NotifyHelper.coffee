#view-source:http://www.jqueryscript.net/demo/jQuery-Plugin-To-Create-Animated-Bootstrap-Alerts-notify/
class NotifyHelper

  Default:(message)->
    $.notify message
    null

  Success:(message)->
    $.notify message, 'success'
    null

  Info:(message)->
    $.notify message, 'info'
    null

  Danger:(message)->
    $.notify message, 'danger'
    null

  Warning:(message)->
    $.notify message, 'warning'
    null

  Error:(message)->
    $.notify message, 'warning'
    null

