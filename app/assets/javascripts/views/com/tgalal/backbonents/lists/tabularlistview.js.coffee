#= require ./listview
class com.tgalal.backbonents.lists.TabularListView extends com.tgalal.backbonents.lists.ListView
  
  
  template: "lists/tabularview/tabularview"
  
  listItemTemplate: JST["com/tgalal/backbonents/lists/tabularview/tabularviewitem"]
  headerTemplate: JST["com/tgalal/backbonents/lists/tabularview/tabularviewheader"]
  
  listItemTagName: "tr"
  iClass: ""
  
  borders: false
    
  _render: ->
    if @borders == true
      @className += " table-bordered"
    
    
    if @selectionMode != 0
      @className += " table-hover"
    
    super()
  