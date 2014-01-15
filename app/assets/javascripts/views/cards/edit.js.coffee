#= require_tree ../com/tgalal/backbonents/buttons
class Kworkflow.Views.CardEdit extends com.tgalal.backbonents.core.Widget

  template: JST['cards/inline_edit']
  
  widgetize: false
  showPreview: true
  showActions: true
  
  events:
    "click .btn-success": "onSubmit",
    "click .btn-cancel": "onCancel"
  
  
  
  onCancel: ->
    self = @
    
    #console.log @$el
    #@$el.children().slideUp(->self.$el.parent().remove())
    @trigger("done")
  
  onSubmit: ->
   
   errors = @form.commit()
   self = @
   if not errors
     @model.save({}, success:->
       self.trigger("card:saved"); self.trigger("done"))
  
  
  
  _render: ->
    
    
    @form = new Backbone.Form({
          model: @model
      }).render();
    
    @form.getFormattedNumber = ->
            
      n = @.fields.number.getValue();
        
      p1 = ""
      p2 = ""
      p3 = ""
      p4 = ""
      
      p1 = n.substr(0,4)
      
      if p1
        p2 = n.substr(4, 4)
        
        if p2
          p3 = n.substr(8, 4)
          
          if p3
            p4 = n.substr(12, 4)
      
      
      p1 + " " + p2 + " " + p3 + " " + p4

    self = @

    @form.on('number:change', (form, field) -> self.$("div.card-number").text(form.getFormattedNumber())) 
    @form.on('nameOnCard:change', (form, field) -> self.$("div.card-name").text(field.getValue()) )
 
    $(@el).html(@template(card: @model, showPreview: @showPreview, showActions: @showActions))
    @$("div.card_info").html(@form.el)
    
    @$("div.card-number").text(@form.getFormattedNumber())