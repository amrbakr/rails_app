#= require ../../com/tgalal/backbonents/buttons/button
#= require ../../com/tgalal/backbonents/dialogs/dialog
class Kworkflow.Views.Buttons.PrintReceiptButton extends com.tgalal.backbonents.buttons.Button
  printDialog: ""
  append: true

  text: "Print Receipt"

  #showDialog: ->
  #  @printDialog.show("PRINT HENA")
  
  showPrint:->
    win = window.open("/cards/" + @model.get('id') + "/receipt", '_blank');
    #win.focus();

  _render: ->

    ###
    dialogRoot = $("<div />")

    

    @$el.append dialogRoot
    
    @printDialog = new com.tgalal.backbonents.dialogs.Dialog(el: dialogRoot)
    @printDialog.render()
    ###


    @$el.html('')
    @bind("clicked", @showPrint, @)

    super();
    
    
