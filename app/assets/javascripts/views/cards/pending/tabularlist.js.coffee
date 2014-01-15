#= require ../common/cards_list
#= require ./tabularlistitem
class Kworkflow.Views.Lists.PendingTabularListView extends Kworkflow.Views.Lists.CardsList
  headerTemplate: JST["cards/pending/tabularlistheader"]
  listItemTemplate: JST["cards/pending/tabularlistitem"]
  footerTemplate: JST["cards/pending/tabularlistfooter"]

  listItemClass: Kworkflow.Views.Lists.PendingTabularListItem

  listItemTagName: "tr"

  selectionMode: 2
  
  borders: true
  
  postRender: ->
    
    @paginator = new com.tgalal.backbonents.misc.pagination.Paginator collection: @collection, el: @$("td.pagination_root")
    @paginator.render()
    
    #console.log($("td.pagination_root"))
