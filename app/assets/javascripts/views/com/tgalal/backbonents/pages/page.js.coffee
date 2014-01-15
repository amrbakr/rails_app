#= require ../core/widget
class com.tgalal.backbonents.pages.Page extends com.tgalal.backbonents.core.Widget
    
  template: "pages/page"
  
  header: "header here"
  body: "body here"
  footer: "footer here"
  
  tagName: "div"
  

  constructor: (o) ->

    @notifier = new com.tgalal.backbonents.dialogs.AlertDialog()

    super o

  getHeaderRoot: ->
    @$(".backbonents-page-header")

  getFooterRoot: ->
    @$(".backbonents-page-footer")
  
  getBodyRoot: ->
    @$(".backbonents-page-body")

  renderHeader: ->
    @getHeaderRoot().html(@header)
    @
  
  
  notify:(title, body)->
    @notifier.setTitle(title)
    @notifier.setBody(body)
    @notifier.show()
  
  renderBody: ->
    @
    
  renderFooter : ->
    @
  
  _render: ->
    
    $(@el).html(@template())
    
    @renderHeader()
    @renderBody()
    @renderFooter()
    
    @notifier.setElement @$(".backbonents-page-modalsink")
    @notifier.render()
    
    @