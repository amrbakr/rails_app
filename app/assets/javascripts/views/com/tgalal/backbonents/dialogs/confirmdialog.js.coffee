#= require ./dialog
#= require_tree ../buttons
class com.tgalal.backbonents.dialogs.ConfirmDialog extends com.tgalal.backbonents.dialogs.Dialog
  
  title: "Confirm"
  
  acceptText: "Accept"
  rejectText: "Cancel"
  
  acceptButton: ->
    if @buttons.length
      @buttons[0]

  constructor: (options) ->
    options = options or {}
    @acceptText = options.acceptText if options.acceptText
    @rejectText = options.rejectText if options.rejectText
    
    super(options)

  render: ->

    @buttons = [ new com.tgalal.backbonents.buttons.AcceptButton(text: @acceptText, cxt:@, onClick:-> @trigger("accepted")),
    new com.tgalal.backbonents.buttons.RejectButton(text: @rejectText, cxt:@, onClick:-> @trigger("rejected"); @hide())]
    
    super()

  