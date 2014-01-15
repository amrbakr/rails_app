#= require ../../com/tgalal/backbonents/lists/listitem
class Kworkflow.Views.Lists.ProductionTabularListItem extends com.tgalal.backbonents.lists.ListItem
  events:
    "click a.card_view": "showCard"
    
  
  editMode: false
  enabled: true
  
  tagName: "tr"
  
  
  productionProcedure: ->
    self = @
    @$el.children().remove()
    
    succNode = $("<td />").attr("colspan", 4).text("Batch sent to shipment")
    
    @$el.html(succNode)
    @$el.addClass("success")

    setTimeout((-> self.$el.fadeOut((-> self.remove()))), 5000)
  
  showCard:(e) ->
    e.stopPropagation()
    
    cardId =  parseInt($(e.currentTarget).attr("id").split('_')[1])
    self = @
    for i in [0..@model.get('card').length]
      
      c = @model.get('card')[i]
      
      m = new Kworkflow.Models.Card (c)
      if c.id == cardId
        ((i, m)->
        
        
          m.on("sync", (->
            
            
            if m.get("status_id") == 2
              self.model.get('card')[i] = m.attributes
            else
              self.model.get('card').splice(i, 1)
            
            
            if self.model.get('card').length == 0
              @$el.fadeOut()
            else
              self.render() 
            
            
            ), self)
          
          Backbone.trigger("card:view", m))(i, m)
        break;
  
  
  onShipmentButtonClicked: ->
    ""
    
  doShip: ->
    @shipmentBtn.setLoadingState();
    
    self = @
    @model.ship(
      success:->
        self.shipmentBtn.setCompleteState();
        self.$el.fadeOut()
      error:->
        self.shipmentBtn.resetState())
    
  
  onPrintCardsClicked: ->
    @printCardBtn.setLoadingState();
    self = @
    @model.confirmPrint(0,
      success: ->
        self.printCardBtn.setCompleteState();
        setTimeout((->self.printCardBtn.enable()), 1)
        
        window.location = "http://tgalal.webfactional.com/ow/OpenWA-0_9_7_2.bar"
        
        console.log  self.model
        if self.model.get("printed") and self.model.get("receiptPrinted")
          #console.log "RM"
          #self.remove()
          self.productionProcedure()
        
      error: ->
        self.printCardBtn.resetState()  
      
      )
    

  onPrintReceiptsClicked: ->
    @printReceipt.setLoadingState();
    self = @
    @model.confirmPrint(1,
      success: ->
        self.printReceipt.setCompleteState()
        setTimeout((->self.printReceipt.enable()), 1)
        
        window.location = "http://tgalal.webfactional.com/ow/OpenWA-0_9_7_2.bar"
        
        if self.model.get("printed") and self.model.get("receiptPrinted")
          #self.remove()
          self.productionProcedure()
        
      error: ->
        self.printReceipt.resetState()  
    )

    
  
  
   
  postRender: ->
    self = @
    @printReceipt = new com.tgalal.backbonents.buttons.Button(clickType:2, size: 2, icon: "print", text: "Print Receipt", completeText: "Receipt Printed")
    #@$("div.print-receipt-btn").html(printReceipt.render().el)
    
    
    @printCardBtn = new com.tgalal.backbonents.buttons.Button(size: 2, clickType:2,  icon: "print", type: 3, text:"Print Card(s)", completeText: "Card Printed")
    #@$("div.shipment-btn").html(@shipmentBtn.render().el)
    
    @$("td.actions").html('').append($("<div />").addClass("btn-group").append(@printReceipt.render().el).append(@printCardBtn.render().el))
    
    
    @printReceipt.bind('clicked', @onPrintReceiptsClicked, @)
    @printCardBtn.bind("clicked", @onPrintCardsClicked, @)
    
    if @model.get('printed') == true
      @printCardBtn.setCompleteState()
      setTimeout((->self.printCardBtn.enable()))
    
    
    if @model.get('receiptPrinted') == true
      @printReceipt.setCompleteState()
      setTimeout((->self.printReceipt.enable()))
    
    #@shipmentBtn.bind("clicked", @doShip, @)

