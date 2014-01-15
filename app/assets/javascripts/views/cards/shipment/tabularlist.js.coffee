#= require ../common/cards_list
#= require ./tabularlistitem

class Kworkflow.Views.Lists.ShipmentTabularListView extends com.tgalal.backbonents.lists.TabularListView
  headerTemplate: JST["cards/shipment/tabularlistheader"]
  listItemTemplate: JST["cards/shipment/tabularlistitem"]
  footerTemplate: JST["cards/shipment/tabularlistfooter"]

  listItemTagName: "tr"

  selectionMode: 2

  borders: true

  listItemClass: Kworkflow.Views.Lists.ShipmentTabularListItem

  initialize: ->
    @collection = new Kworkflow.Collections.Batches()
    @collection.status_id= 3
    super()

  fetch:->
    @collection.fetch(reset: true)

  postRender: ->
    
    @paginator = new com.tgalal.backbonents.misc.pagination.Paginator collection: @collection, el: @$("td.pagination_root")
    @paginator.render()