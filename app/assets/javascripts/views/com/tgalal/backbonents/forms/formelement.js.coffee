#= require ../core/widget
class com.tgalal.backbonents.forms.FormElement extends com.tgalal.backbonents.core.Widget
  formTemplate: JST["com/tgalal/backbonents/forms/formelement"]
  
  label: "ddd"
  name: ""
  id: ""

  widgetize: false
  
  rawElement: false
  
  _render:(inputField) ->
    
    
    $(inputField).attr("name", @name).attr("id", @id)

    if @rawElement
      $(@el).html(inputField)
    else
      formTempl = @formTemplate label: @label, forId: @id
        
      $(@el).html(formTempl)
      
      @$("div.controls").prepend(inputField)
      #$(inputField).insertAfter(@$("label"))
    
    @
