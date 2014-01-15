#= require ../core/widget
#= require_tree ../buttons
#= require_tree ../dialogs
#= require_tree ../lists
class com.tgalal.backbonents.misc.Demo extends com.tgalal.backbonents.core.Widget
  template: "misc/demo"
  
  _render:->
    $(@el).html(@template())
    
    #buttons
    btnAcc = new com.tgalal.backbonents.buttons.AcceptButton() #el: @$(".accept_button")
    btnRej = new com.tgalal.backbonents.buttons.RejectButton() #el: @$(".reject_button")
    
    @$(".accept_button").html(btnAcc.render().el)
    @$(".reject_button").html(btnRej.render().el)
    
    btnAcc.bind("clicked", -> @setCompleteState())
    
    btnAcc.render()
    btnRej.render()
    
    #dialogs
    
    confirm = new com.tgalal.backbonents.dialogs.ConfirmDialog el: @$(".confirm_dialog")
    
    confirm.title = "Confirm"
    confirm.body = "Are you sure ?"
    
    confirm.render()
    
    
    
    btnConfirm = new com.tgalal.backbonents.buttons.Button text: "Confirm dialog"
    
    @$(".show_confirm_btn").html(btnConfirm.render().el)
    
    btnConfirm.bind("clicked", -> confirm.show())
    btnConfirm.render()
    
    ti = new com.tgalal.backbonents.forms.TextInput el: @$(".text_input"), placeHolderText: "Insert text here"
    ti.render()
    
    ta = new com.tgalal.backbonents.forms.TextArea el: @$(".text_area"), placeHolderText: "Insert text here"
    ta.render()
    
    
    c = new Backbone.Collection()
    for i in [1..10]
      m = new Backbone.Model()
      m.set("title", "Item " + i)
      m.set("description", "Desc " + i)
      c.add(m)
      
    l = new com.tgalal.backbonents.lists.ListView collection: c, el: @$(".unordered_list"), selectionMode: 2, removeLevel: 1
    l.render()
    
    l = new com.tgalal.backbonents.lists.TabularListView collection: c, el: @$(".tabular_list"), selectionMode: 2, borders: true
    l.render()
    
    f = new com.tgalal.backbonents.forms.Form el: @$(".form_root")
    
    
    set = f.addFieldset("Field set 1")
    
    f.addFieldset("Field set jjjjjjj")
    f.addFieldset("Field set kkkk")
    
    for i in [1..5]
      e = new com.tgalal.backbonents.forms.TextInput label: "Element " + i
      
      set.addElement e
    f.render()
    
    
    m = new Kworkflow.Models.Card();
    
    m.set("status_id", 1);
    
    c = new Kworkflow.Views.Card model: m, el: $(".card_show")
    
    c.render();
    
    
    
    
