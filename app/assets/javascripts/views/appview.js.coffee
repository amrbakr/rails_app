class Kworkflow.Views.KiwiAppView extends Backbone.View
  el: "#cards_root"
  
  transitionDuration: 200

  currentView: ""
  
  
  stack: []
  
  
  push: (view) ->
    
    @stack.push(view)
    
    @_show(@stack.length - 1)
  
  _show: (ind)->
    
    v = @stack[ind].render().el
    $(v).hide()
    $(@el).html(v)
 
    $(@el).children().fadeIn(@transitionDuration)
  
  show: (view)->
    
    self = @
    
    if $(@el).children().length
      $(@el).children().fadeOut(@transitionDuration,-> 
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
