#= require ../../com/tgalal/backbonents/lists/listitem
class Kworkflow.Views.Lists.ShipmentTabularListItem extends com.tgalal.backbonents.lists.ListItem
  events:
    "click a.card_view": "showCard"
    
  
  editMode: false
  enabled: true
  
  tagName: "tr"
  
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
  
  onKiwiConfirm: ->
    @kConfirmBtn.setLoadingState();
    
    self = @
    
    @model.ownConfirm(
      success: ->
        self.kConfirmBtn.setCompleteState()

      error: ->
        self.kConfirmBtn.resetState()
        
        self.kConfirmBtn.$el.toggleClass("active")
    )
    
  
  onCourierConfirm: ->
    @cConfirmBtn.setLoadingState();
    
    self = @
    
    @model.cConfirm(
      success: ->
        self.cConfirmBtn.setCompleteState()

      error: ->
        self.cConfirmBtn.resetState()
        
        self.cConfirmBtn.$el.toggleClass("active")
    )
      
    
  postRender: ->

    @kConfirmBtn = new com.tgalal.backbonents.buttons.Button(text: "Card Activated", size: 2, type: 3, clickType: 2)
    @kCancelBtn = new com.tgalal.backbonents.buttons.Button(text: "Cancel Card", size: 2, type: 2, clickType: 2)
   
   
   
    @cConfirmBtn = new com.tgalal.backbonents.buttons.Button(text: "Courier Confirm",size: 2, type: 1, clickType: 2, completeText: "Courier Confirmed")
    @cRetryBtn = new com.tgalal.backbonents.buttons.Button(text: "Retrying",size: 2, type: 1, clickType: 2)
    @cReturnedBtn = new com.tgalal.backbonents.buttons.Button(text: "Returned",size: 2, type: 1, clickType: 2)

    self = @
    ###
    if @model.get('kconfirm') == true
      @kConfirmBtn.setCompleteState()
    
    if @model.get('cconfirm') == true
      @cConfirmBtn.setCompleteState()
    ###
    
    @kConfirmBtn.bind("clicked", @onKiwiConfirm, @)
    @cConfirmBtn.bind("clicked", @onCourierConfirm, @)
    
    @$("td.kiwi-actions, td.courier-actions").html('')
    
    @$("td.kiwi-actions").append(@kConfirmBtn.render().el).append($("<div />")).append(@kCancelBtn.render().el)
    
    @$("td.courier-actions").append(@cConfirmBtn.render().el).append($("<div />")).append(@cRetryBtn.render().el)
    .append($("<div />")).append(@cReturnedBtn.render().el)
    
    @
