#= require ./dialog
#= require_tree ../buttons
class com.tgalal.backbonents.dialogs.AlertDialog extends com.tgalal.backbonents.dialogs.Dialog
  
  title: "Alert"
  
  acceptText: "Ok"
  
  acceptButton: ->
    if @buttons.length
      @buttons[0]

  constructor: (options) ->
    options = options or {}
    @acceptText = options.acceptText if options.acceptText
    
    super(options)

  render: ->

    @buttons = [ new com.tgalal.backbonents.buttons.AcceptButton(text: @acceptText)]
    @buttons[0].bind('clicked', (-> @trigger("accepted"); @hide()), @)
    
    
    
    super()

  