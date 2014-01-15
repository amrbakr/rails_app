#= require ../../com/tgalal/backbonents/dialogs/dialog
class Kworkflow.Views.CardDialog extends com.tgalal.backbonents.dialogs.Dialog
  acceptText: "Close"
  
  title: "Card Information"
  
  show: (card)->
    @editView.model = card
    @editView.render()
    super(@editView.el )


  _render: ->
    
    
    
    ###
    saveButton = new com.tgalal.backbonents.buttons.AcceptButton(text: "Save", cxt:@, onClick:-> @trigger("accepted"))
    
    saveButton.bind("clicked", -> 
      saveButton.setLoadingMode(); 
      @editView.onSubmit(); 
    , @)
    
    @editView.bind("card:saved", (-> saveButton.resetMode()), @)
    
    
    @buttons =  [ saveButton,
    new com.tgalal.backbonents.buttons.RejectButton(text: "Close", cxt:@, onClick:-> @trigger("rejected"); @hide())]
    ###
    
    super()
    
    @editView = new Kworkflow.Views.Card(actionsEl: @$(".modal-footer"))
    
    @bind("hidden", (-> @editView.remove()), @)
    
    @
