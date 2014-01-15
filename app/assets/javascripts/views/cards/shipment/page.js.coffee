#= require ../../com/tgalal/backbonents/pages/page
class Kworkflow.Views.Pages.ShipmentPage extends com.tgalal.backbonents.pages.Page
  #template: JST['cards/production/page']
  template: JST['cards/shipment/page']
  
  initialize: ->
    Backbone.off("card:view")
    Backbone.on("card:view", @onShowCard, @)
  
  onShowCard:(c)->
    @cardDialog.show(c)
    
  
  postRender:->
    @cardDialog = new Kworkflow.Views.CardDialog el: @$(".cardview-dialog")
    @cardDialog.render()

  renderBody: ->
    @cardsList = new Kworkflow.Views.Lists.ShipmentTabularListView el: @getBodyRoot(), selectionMode: 0

    @cardsList.render()
    @cardsList.fetch()
    
    
    #@cardsList.bind("cardTriggered", _.bind(@onCardTriggered, @))