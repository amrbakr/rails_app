#= require ../core/widget
class com.tgalal.backbonents.buttons.Button extends com.tgalal.backbonents.core.Widget

  widgetize: false

  text: ""
  target: "javascript:void(0)"
  
  type: 1
  
  clickType: 1 #1 click, 2 toggle
  
  events: "click": "clickedClbk"

  size: 3
  
  icon: ""

  cxt: @

  anchor: false
  
  tagName: "button"
  className: "btn"
  
  loadingText: "Loading..."
  completeText: "Done"
  disableOnComplete: true
  
  clickedClbk: (e) ->
    @trigger("clicked")
  
  setCallbackContext: (c) ->#@@TODO RM
    @cxt = c

  setLoadingState: ->
    @$el.data("loading-text", @loadingText)
    @$el.button("loading")
    
  setCompleteState: ->
    @$el.data("loading-text", @completeText)
    @$el.button("loading")
    
  enable: ->
    @$el.attr("disabled",false)
  
  disable: ->
    @$el.attr("disabled","disabled")
  
    
  resetState: ->
    @$el.button("reset")
    
    @$el.attr("disabled","enabled")

  setIcon: (icon) ->
    
    @$("i").remove("icon-" + @icon)
    
    if icon
      @$("i").addClass("icon-" + icon)
    
    @icon = icon
    
  constructor: (options)->
    options = options or {}
    #@events = (-> "click a": options.click) if options.click
    @text = options.text if options.text
    @target = options.target if options.target
    @type = options.type if options.type
    
    if options.onClick
      @bind("clicked", options.onClick, options.cxt or @)
    
    
    @cxt = options.cxt if options.cxt

    super(options)

  _render: ->

    super()

    switch @type
      when 1 then @$el.addClass("btn-primary")
      when 3 then @$el.addClass("btn-success")
      when 2 then @$el.addClass("btn-danger")

    switch @size
      when 1 then @$el.addClass("btn-mini")
      when 2 then @$el.addClass("btn-small")
      when 4 then @$el.addClass("btn-large")
    
    
    if @clickType == 2
      @$el.attr("data-toggle", "button")

    @$el.text(@text + " ")

    if @icon
      @$el.append($("<i />").addClass("icon-white icon-" + @icon))

    @$el.attr("data-complete-text", @completeText)
    @$el.attr("data-loading-text", @loadingText)
    

    #super(text: @text, loadingText:@loadingText, completeText: @completeText, target: @target, class: c, anchor: @anchor)    
    