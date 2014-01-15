#= require ./formelement
class com.tgalal.backbonents.forms.TextInput extends com.tgalal.backbonents.forms.FormElement
  template: "forms/textinput"
  
  placeHolderText: "Type something"
  value: ""
  
  #className: "input-medium search-query"
  
  _render: ->
    super( @template(value: @value, placeholder: @placeHolderText))