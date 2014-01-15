#= require ../core/widget
#= require_tree ../buttons
class com.tgalal.backbonents.dialogs.Dialog extends com.tgalal.backbonents.core.Widget
  
  widgetize: false
  
  templateRoot:(p) -> 
    super("dialogs")
  
  template: 'dialog'
  
  
  title: ""
  body:""
  
  bodyHtml:""
  
  modEl: ""
  
  buttons: []
  
  initialize: ->
    
    @buttons = []
  
  
  $:(sel) ->
    
    res = $(@getDialogRootEl()).find(sel)
    
    if not res.length
      res = super(sel)
    
    res
  
  getDialogRootEl: ->
    return @modEl
  
  clearNotify: ->
    @$(".modal-notify:first").html('')
    
  notify: (notif, bdy) ->
    
    @clearNotify()

    if typeof notif != "object"
      notif = new com.tgalal.backbonents.notifications.InfoNotification title: notif, body: bdy
      
      
    notif.setElement(@$(".modal-notify:first"))
    notif.show()
    
  
  setTitle: (t) ->
    @$("h3").text(t)
    
  setBody: (b) ->
    @$("div.modal-body p").text(b)

  getRootEl: ->
    @$("div.bodyHtml")

  addButton: (b) ->
    @buttons.push(b)
  
  show: (bodyHtml) ->
    html = bodyHtml or @bodyHtml
    
    if html
      @$("div.bodyHtml:first").html(html)
    @modEl = @$(".modal:first").modal("show": true)
  
  
  hide: ->
    @modEl.modal('hide')
  
  _render: ->
    
    $(@el).append(@template(title: @title, body: @body))  
    
    
    self = @
    @$(".modal:first").on('hidden', (-> self.trigger("hidden"); self.modEl = ""))
    
    for b in @buttons
      #@$(".modal-footer:first").append(wrapper)
      
      #b.setElement(wrapper)
      
      @$(".modal-footer:first").append(b.render().el)
