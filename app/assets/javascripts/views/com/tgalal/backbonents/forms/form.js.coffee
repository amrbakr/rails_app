#= require ../core/widget
#= require ./fieldset
class com.tgalal.backbonents.forms.Form extends com.tgalal.backbonents.core.Widget
  template: "forms/form"
  
  elements: []
  
  formElementTagName: "div"
  formElementClassName: "control-group"

  tagName: "div"
  
  widgetize: false
  
  className:"form-horizontal"
    
  constructor:(options) ->
    
    @elements = []
    
    super(options)
  
  addFieldset:(labelOrFieldset) ->
    
    if typeof labelOrFieldset == "object"
      labelOrFieldset.form = @
      labelOrFieldset.formElementTagName = @formElementTagName
      labelOrFieldset.formElementClassName = @formElementClassName
 
      @elements.push(labelOrFieldset)
      
    else
      @elements.push(new com.tgalal.backbonents.forms.Fieldset formElementTagName: @formElementTagName,
      formElementClassName: @formElementClassName, label: labelOrFieldset, form: @)
      
    @elements[@elements.length - 1]
    
  addElement:(el, render)->
    
    formElementWrapper = $(document.createElement(@formElementTagName))
      .addClass(@formElementClassName);
    
    
    el.setElement(formElementWrapper)
    
    @elements.push(el)
    
    if render
      el.render()
      
  _render:->
    super()
    
    for e in @elements
      @$("form").append(e.render().el)
      
    
    @
    
      
   
