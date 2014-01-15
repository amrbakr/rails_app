#= require ../core/widget
class com.tgalal.backbonents.forms.Fieldset extends com.tgalal.backbonents.core.Widget
  template: "forms/fieldset"
  elements: []

  formElementTagName: "div"
  formElementClassName: "control-group"
    
  label: ""
  
  form: ""
    
  widgetize: false
  
  tagName: "fieldset"
  
  constructor:(options)->
    
    @elements = []
    
    super(options)
  
  addElement: (el, render)->
    
    formElementWrapper = $(document.createElement(@formElementTagName))
      .addClass(@formElementClassName);
      
      el.setElement(formElementWrapper)
    
    @elements.push(el)
    
    if render
      el.render()
      
      
  _render:->
    super(label: @label)
    for e in @elements
      @$el.append(e.render().el)
      #$(e.render().el).insertAfter(@$("legend"))
      #@$("fieldset").append(e.render().el)
      
    @
    
    
    
