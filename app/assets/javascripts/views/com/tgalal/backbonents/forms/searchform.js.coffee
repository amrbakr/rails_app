#= require ../core/widget
#= require ./textinput
#= require ../buttons/button
class com.tgalal.backbonents.forms.SearchForm extends com.tgalal.backbonents.forms.TextInput
  template: "forms/searchform"
  
  placeHolderText: "Search..."
  showSubmit: true
  submitButtonText: "Search"
  
  #events: onSubmit, onTextChanged
  
  @_render:->
    ti = new com.tgalal.backbonents.forms.TextInput el: @$(".text_input"), placeHolderText: "Insert text here", append: true
    ti.className = "input-medium search-query"
      
    ti.render()
