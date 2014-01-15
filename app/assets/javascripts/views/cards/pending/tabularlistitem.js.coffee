#= require ../../com/tgalal/backbonents/lists/listitem
class Kworkflow.Views.Lists.PendingTabularListItem extends com.tgalal.backbonents.lists.ListItem
  events:
    "click a.card_edit": "editClicked"
    "click a.card_view": "showCard"
    
  
  editMode: false
  enabled: true
  
  tagName: "tr"
  
  
  showCard:(e) ->
    e.stopPropagation()
    Backbone.trigger("card:view", @model)
    
  
  _render:(options) ->
   
   if @model.get('status_id') == 1
     super(options)
   else
    #unrender
    @$el.fadeOut()
    
  
  editClicked: (e) ->
    e.stopPropagation()

    if not @editMode and @enabled
      id = @$("td:first").text()
      
      @editMode = true
      
      
      
      trp = @$("td").parent()
      tr = $("<tr />").addClass('card_inline_edit')
      
      tr.insertAfter(trp)
      
      editView = new Kworkflow.Views.CardEdit tagName: "td", model: @model
      
      editView.$el.attr("colspan", 9)
      
      tr.append(editView.el)
      
      self = @
      editView.bind("done", -> 
        editView.$el.children().slideUp(-> editView.$el.parent().remove())
        self.editMode = false)
      
      editView.render();

      editView.$("div:first").hide();
      editView.$("div:first").slideDown();