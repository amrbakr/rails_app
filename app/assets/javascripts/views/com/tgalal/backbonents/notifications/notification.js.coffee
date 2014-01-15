#= require ../core/widget
class com.tgalal.backbonents.notifications.Notification extends com.tgalal.backbonents.core.Widget
  timeout: 0
  allowDismiss: false
  
  title: ""
  body: ""
  
  type: 1
  
  TYPE_INFO = 0
  TYPE_WARNING = 1
  TYPE_ERROR = 2
  TYPE_SUCCESS = 3
  
  template: "notifications/notification"

  show: ->
    @render()
    
    if @timeout
      setTimeout(@hide, @timeout)
    
  
  hide: ->
    $(@el).children.remove();
  
  render: ->
    
    cl = "alert-info" #default
    
    switch @type
      when TYPE_ERROR then cl = "alert-error"
      when TYPE_SUCCESS then cl = "alert-success"
      when TYPE_WARNING then cl = ""
      when TYPE_INFO then cl = "alert-info"
      
    $(@el).html(@template(allowDismiss: @allowDismiss, title: @title, body: @body, "class": cl))
