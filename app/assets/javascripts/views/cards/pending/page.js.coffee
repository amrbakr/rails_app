#= require ../../com/tgalal/backbonents/pages/page
class Kworkflow.Views.Pages.PendingPage extends com.tgalal.backbonents.pages.Page
  template: JST['cards/pending/page']

  events: "click a.produce": "proceedConfirm"

  queueList: {}
  
  initialize: ->
    dm = title: "nameOnCard", description: "number"
    @queueList = new Kworkflow.Views.PendingQueuebox collection: new Kworkflow.Collections.XCards(), listItemTemplate: JST["cards/pending/queuelistitem"]
    
    
    @queueList.bind("item:removed", @onQueueItemRemoved, @)
    @queueList.widgetize = false
    @queueList.dataMapping = dm
    @queueList.collection.reset()

    Backbone.off("card:view")
    Backbone.on("card:view", @onShowCard, @)
    
  onShowCard:(c)->
    @cardDialog.show(c)

  onQueueItemRemoved:(qi) ->
    for i in @cardsList.selectedItems
      if i.model.get("id") == qi.model.get("id")
        @cardsList.unselect(i)
        break
  
  proceedConfirm: (e)->
    
    
    if not @queueList.items.length
      @notify("Error", "Please select items first")
      return
    
    wrapper = $("<div class='form-horizontal' />")
    
    inp = new com.tgalal.backbonents.forms.TextInput(label: "Batch title", placeHolderText: "Leave blank for non batch")
    
    inp.css("margin-bottom", "20px")
    
    container = $("<table style='width:100%' />")
    
    for c in @queueList.items
      row = $("<tr id=\"prod_"+c.model.get("id")+"\" />")
      row.append($("<td />").text(c.model.get("id")))
      row.append($("<td />").text(c.model.get("number")))
      row.append($("<td />").text(c.model.get("nameOnCard")))
      row.append($("<td><span style='display:none' class='icon-ok' /></td>"))
      
      container.append(row)
    
    wrapper.append(inp.render().el).append(container)
    
    @productionConfirmDialog.acceptButton().resetState()
    @productionConfirmDialog.clearNotify()
    @productionConfirmDialog.show(wrapper)

  clearQueue: ->
    @queueList.collection.reset()

  produce: ->
    @productionConfirmDialog.clearNotify()
    @productionConfirmDialog.acceptButton().setLoadingState()
    
    @productionConfirmDialog.$("tr").each ->
      
      td = $(@).find("td:last")
      
      td.append($("<img />").attr("src", "/assets/spinner.gif").addClass("spinner"))
    
    
    self = @
    
    
    batchTitle = @productionConfirmDialog.$("input").val()
    
    if batchTitle.trim()

      @queueList.collection.produce(@productionConfirmDialog.$("input").val(),
        success: ->
          self.productionConfirmDialog.acceptButton().setCompleteState()
  
          for c in self.cardsList.selectedItems
          
            self.productionConfirmDialog.$("tr#prod_"+c.model.get("id") + " td:last img").remove()
            self.productionConfirmDialog.$("tr#prod_"+c.model.get("id") + " td:last span").show()
            
            $(c.el).fadeOut()
          
          for c in self.cardsList.items
            self.cardsList.unselect(c)
          
          
          self.clearQueue()
        error:(status, message, response) ->
          
          errors = []
          for k, v of response
            errors.push(k + " " + v)
          
          self.productionConfirmDialog.acceptButton().resetState()
  
          #alert status + ": " + message
          self.productionConfirmDialog.notify(new com.tgalal.backbonents.notifications.ErrorNotification(title: "Error", body: errors.join(", ")))
          for c in self.cardsList.selectedItems
            self.productionConfirmDialog.$("tr#prod_"+c.model.get("id") + " td:last img").remove()
              
        )
    else

    
      for c in @cardsList.selectedItems
        
        ((s) ->
          
          batch = new Kworkflow.Models.Batch()
          batch.set('card', [c.model])
          
          batch.save({}, success:(m) ->
            self.productionConfirmDialog.$("tr#prod_"+m.get("card")[0].get("id") + " td:last img").remove()
            self.productionConfirmDialog.$("tr#prod_"+m.get("card")[0].get("id") + " td:last span").show()
            
            
            self.cardsList.unselect(s)
            
            $(s.el).fadeOut()
            #self.cardsList.getRowById(m.get("id")).fadeOut()
            
          ))(c)
      self.productionConfirmDialog.acceptButton().setCompleteState()
      @clearQueue() #@@TODO remove only saved
    

  onItemSelected:(item) ->
    @queueList.collection.add(item.model)
    @queueList.collection.trigger("reset")
    
  onItemUnselected:(item) ->
    
    @queueList.collection.remove(item.model)
    @queueList.collection.trigger("reset")
  
  onCardsListRendered: ->
    self = @
    @queueList.collection.each (c) ->
      for i in self.cardsList.items
        if i.model.get("id") == c.get("id")
          self.cardsList.select(i)
      
  
  postRender: ->
    @productionConfirmDialog = new com.tgalal.backbonents.dialogs.ConfirmDialog(el: @getFooterRoot())
    @productionConfirmDialog.rejectText = "Close"
    @productionConfirmDialog.acceptText = "Produce!"
    @productionConfirmDialog.render()
    @productionConfirmDialog.acceptButton().disableOnComplete = true
    
    @productionConfirmDialog.bind("accepted", @produce, @)
    
    
    @cardDialog = new Kworkflow.Views.CardDialog el: @$(".cardview-dialog")
    @cardDialog.render()
  
  renderBody: ->
    @cardsList = new Kworkflow.Views.Lists.PendingTabularListView el: @getBodyRoot()
    
    @cardsList.render()
    @cardsList.fetch()
    
    @cardsList.bind("rendered", @onCardsListRendered, @)
    
    @queueList.setElement(@$(".queue_list"))
    @queueList.render()
    
    @cardsList.bind("selected", @onItemSelected, @)
    @cardsList.bind("unselected", @onItemUnselected, @)
    
    
    #@cardsList.bind("cardTriggered", _.bind(@onCardTriggered, @))