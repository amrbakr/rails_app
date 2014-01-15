#= require ./listitem
class com.tgalal.backbonents.lists.ListView extends com.tgalal.backbonents.core.Widget
  
  liClass: "media"
  
  template: "lists/listview/listview"
  
  listItemTemplate: JST["com/tgalal/backbonents/lists/listview/listviewitem"]
  
  items: []
  selectedItems: []
  
  dataMapping: image: "image", description: "description", title: "title"
  
  #itemWrapper: "<li />"
  
  #tagName: "li"
  
  headerTemplate: ""
  footerTemplate: ""

  selectionMode: 0

  MODE_NOSELECT = 0
  MODE_SELECT = 1
  MODE_MULTISELECT = 2

  listItemClass: com.tgalal.backbonents.lists.ListItem
  
  listItemTagName: "li"
  
  
  removeLevel: 0 #0no remove, 1 remove from list, 2 remove from list and server
  
  #widgetize: false
  
  initialize: ->
    
    
    @collection.bind 'reset', @render, @
    
    @collection.bind 'fetch', @onFetch, @
    
    
    #@collection.on("add", @render, @)
    #@collection.on("remove", @render, @)
  
  
  constructor:(options)->
    @items = []
    @selectedItems = []
    
    super(options)
  
  onRemoveRequested:(listitem) ->
    @unselect(listitem)
    
    
    if @removeLevel == 2
      listitem.setLoadingMode()
      #@@TODO ACTUALLY REMOVE
    else if @removeLevel == 1
      for i in [0..@items.length]
        if @items[i].cid == listitem.cid
          @items.splice(i, 1)
          break
      @collection.remove(listitem.model)
      @trigger("item:removed", listitem)
      listitem.remove()
      

  onFetch:->
    @setLoadingMode()
  
  select: (item) ->
    if not item.isSelected()
      @onItemTriggered(item)
    
  unselect: (item) ->
    if item.isSelected()
      @onItemTriggered(item)
  
  onItemTriggered:(item) ->

    @trigger("triggered", item)
    switch @selectionMode
      when MODE_SELECT
        if item.isSelected()
          @selectedItems.pop()
          item.unselect()
        else
          if @selectedItems.length
            @selectedItems.pop().unselect()
            @trigger("unselected", item)
          
          item.select()
          @selectedItems.push(item)
          @trigger("selected", item)
  
      when MODE_MULTISELECT
        
        if item.isSelected()
          item.unselect()
          
          for i in [0..@selectedItems.length]
            tmp = @selectedItems[i]
            if tmp.cid = item.cid
              @selectedItems.splice(i, 1)
              break
           
           @trigger("unselected", item)
         else
          item.select()
          @selectedItems.push(item)
          @trigger("selected", item)
  
  _render:->
    @setNormalMode()
    #$(@el).html(@template())
    super()
    if @headerTemplate
      @$(".listview-header").html(@headerTemplate(collection: @collection))
      
    if @footerTemplate
      @$(".listview-footer").html(@footerTemplate(collection: @collection))
    
    
    allowRemove = @removeLevel > 0
    
    @items = []
    @selectedItems = []
    
    console.log @collection
    
    if @collection
      @collection.each (c) =>
        item = new @listItemClass(tagName: @listItemTagName, template: @listItemTemplate, model: c, dataMapping: @dataMapping, allowRemove: allowRemove)
        
        item.bind("triggered", @onItemTriggered, @)
        item.bind("remove", @onRemoveRequested, @)
        
        @$(".listview-body:first").append(item.render().el)
        
        @items.push(item)
        
  
        item.render()

    @trigger("rendered")
    @