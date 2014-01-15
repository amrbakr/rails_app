#= require ./dialog
#= require_tree ../buttons
class com.tgalal.backbonents.dialogs.InfoDialog extends com.tgalal.backbonents.dialogs.Dialog
  
  title: "Info"
  
  acceptText: "Ok"
  
  
  initialize: (o) ->
    super(o)
    @buttons = [ new com.tgalal.backbonents.buttons.AcceptButton(text: @acceptText, cxt:@, onClick:-> @trigger("accepted"))]
    
 
  
  constructor: (options) ->
    
    @acceptText = options.acceptText if options.acceptText
    
    super(options)
  
  _render: ->
    console.log "ahom"
    console.log @buttons
    super()
