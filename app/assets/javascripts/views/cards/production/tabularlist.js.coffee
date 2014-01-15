#= require ../common/cards_list
#= require ./tabularlistitem

class Kworkflow.Views.Lists.ProductionTabularListView extends com.tgalal.backbonents.lists.TabularListView
  headerTemplate: JST["cards/production/tabularlistheader"]
  listItemTemplate: JST["cards/production/tabularlistitem"]
  footerTemplate: JST["cards/production/tabularlistfooter"]

  listItemTagName: "tr"

  selectionMode: 2

  borders: true

  listItemClass: Kworkflow.Views.Lists.ProductionTabularListItem

  initialize: ->
    @collection = new Kworkflow.Collections.Batches()
    @collection.status_id= 2
    super()

  fetch:->
    @collection.fetch(reset: true)

  postRender: ->
    
    @paginator = new com.tgalal.backbonents.misc.pagination.Paginator collection: @collection, el: @$("td.pagination_root")
    @paginator.render()