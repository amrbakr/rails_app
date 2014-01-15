class com.tgalal.backbonents.lists.ListItem extends com.tgalal.backbonents.core.Widget

  template: "lists/listview/listviewitem"
  
  tagName: "li"
  
  dataMapping: 
    image: "image", 
    description: "description", 
    title: "title"

  selectionClass: "info"
  
  _ev: "click":"clicked",
  "click button.close": "onRemove"
  
  widgetize: false
  #private
  @state =  0 #0 norm, 1 selected
  
  allowRemove: false
  
  initialize: (options)->
    @model.on('sync',@render,@)
    
    super(options)
    
  remove: ->
    super()
    #@$el.fadeOut(-> super.call(self))
  
  setLoadingMode: ->
    @loadingMode = true
    @$(".listitem-controls").children().hide()
    @$(".spinner").show()
  
  setNormalMode: ->
    @loadingMode = false
    @$(".listitem-controls").children().hide()
    @$("button.close").show()
  
  onRemove:(e) ->
    
    @trigger("remove", @)
    
    e.stopPropagation()
  
  select: ->
    $(@el).addClass(@selectionClass)
    @state = 1
  
  unselect: ->
    $(@el).removeClass(@selectionClass)
    @state = 0
    
  
  isSelected: ->
    @state == 1
    
  
  toggleSelection: ->
    if @isSelected()
      @unselect()
    else
      @select()

  clicked: ->
    if not @loadingMode
      @trigger("triggered", @)
  
  constructor: (options) ->
    
    @template = options.template if options.template
    @dataMapping = options.dataMapping if options.dataMapping
    
    
    
    $.extend(@events, @_ev)

    
    super(options)
  
  _render:->
    $(@el).html(@template(item: @model, mapping: @dataMapping, allowRemove: @allowRemove))
