class com.tgalal.backbonents.core.Widget extends Backbone.View
  
  
  baseTemplate: JST["com/tgalal/backbonents/core/widget"]
  
  widgetize: true
  
  events: {}
  
  append: false
  
  loadingText: "Working"
  
  className: ""
    
  loadingMode: false
  
  templateRoot: (p) -> 
    if p
      "com/tgalal/backbonents" + "/" +p
    else
      "com/tgalal/backbonents"
  
  constructor: (options) ->

    if @template

      if typeof(@template) != "function"
        @template = JST[@templateRoot() + "/"+@template]
        
    for k, v of options
     
      if k != "template" and k != "templateRoot"
        if typeof @[k] != "undefined"
          @[k] = v
    
    super(options)
    
  
  remove: ->
    @.undelegateEvents()
    @$el.removeData().unbind()
    super()
    Backbone.View.prototype.remove.call(@);
  
  
  clearNotify: ->
    @
  
  notify: ->
    
    @  
  
  preRender: ->
    @
    
  postRender: ->
    @

  _render:(options) ->
    options = options or {}
    options.className = @className if @className
    
    if typeof(@template) == "function"
      if not @append
        $(@el).html(@template(options))
      else
        $(@el).append(@template(options))
    @

  _widgetize :->
    $(@el).html(@baseTemplate())
    @setElement(@$('div.backbonent-widget-body'))
    
    @widgetize = false
  
  
  setLoadingMode:(text) ->
    widgetNode = @$el.parent()
    
    @loadingMode = true
    if widgetNode.hasClass "backbonent-widget"

      widgetNode.find("span.wip-title").text(text or @loadingText)
      #widgetNode.find("div.backbonent-widget-body:first").css("opacity", 0.3)
      widgetNode.find("div.backbonent-widget-wip:first").show()
    
  setNormalMode: ->
    @loadingMode = false
    widgetNode = @$el.parent()
    #@$("div.backbonent-widget-body:first").css("opacity", 1)
    widgetNode.find("div.backbonent-widget-wip:first").hide()
  
  
  css:(prop, val, sel) ->
    if sel
      @$(sel).css(prop, val)
    else
      @$el.css(prop,val)
  
  render: ->
    
    if @widgetize
      @_widgetize()
    
    @preRender()
    
    @_render()
    @postRender()
    
    @
