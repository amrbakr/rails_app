#= require ../core/widget
class com.tgalal.backbonents.panes.Pane extends com.tgalal.backbonents.core.Widget
  #el: "#cards_root"
  
  template: "panes/pane"

  transitionDuration: 200

  currentView: ""
  
  @statusIndicator: ""

  stack: []
  
  constructor: (options)->
    #Backbone.on("all", @setWorking, @)
    #Backbone.on("sync", @setNormal, @)
    super(options)
    
  setWorking: ->
    console.log("CAUGHT REQ")
    @statusIndicator.setWorking()
    
  setNormal: ->
    @statusIndicator.setNormal()
  
  push: (view) ->

    @stack.push(view)
    
    @_show(@stack.length - 1)
  
  _show: (ind)->
    
    #@stack[ind].setElement(@root())
    v = @stack[ind].render().el
    
    @root().html(v)
    
    $(v).hide()
    #@root().html(v)
 
    $(v).fadeIn(@transitionDuration)
  
  show: (view)->
    
    self = @
    
    if @root().children().length
      @root().children().fadeOut(@transitionDuration,-> 
       self.pop()
       self.push(view)
      )
    else
      @replace(view)

  replace: (view)->
    
    @pop()
    @push(view)
  
  pop: ->
    
    if @stack.length
    
      v = @stack.pop()
      
      v.remove();
      v.unbind();
  
  
  root: ->
    @$("div.backbonents-page-root")
  
  _render: ->
    $(@el).html(@template())
    @statusIndicator = new com.tgalal.backbonents.misc.StatusIndicator el: @$(".backbonents-wip-idicator")
