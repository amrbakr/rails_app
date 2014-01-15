#= require ../../com/tgalal/backbonents/lists/tabularlistview
class Kworkflow.Views.Lists.CardsList extends com.tgalal.backbonents.lists.TabularListView
  status_id: 1
 
  initialize:->
    @collection = new Kworkflow.Collections.PaginatedCards status_id: @status_id
    
    super()
    #@collection.bind 'reset', @render, @
    
    
    
  
  fetch:->
    @collection.fetch(reset: true)
    
    
