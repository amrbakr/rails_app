#= require_tree ../com/tgalal/backbonents/buttons
#= require ../com/tgalal/backbonents/dialogs/confirmdialog
class Kworkflow.Views.Card extends com.tgalal.backbonents.core.Widget

  template: JST['cards/show']

  widgetize: false
  actionsEl: ".card_actions"
  
  produceBtn: ""
  printCardBtn: ""
  printReceiptBtn: ""
  
  buttons = []
  
  notify:(t, err) ->
    
    if err
      n = new com.tgalal.backbonents.notifications.ErrorNotification title: "Error!", body: t, el: @$(".notif")
    else
      n = new com.tgalal.backbonents.notifications.SuccessNotification title: "Success!", body: t, el: @$(".notif")

    n.render()
    
  onSaveClicked: ->
   @$(".notif").html('')
   
   @disableButtons()
   
   @saveBtn.setLoadingState()
   errors = @form.commit()
   self = @
   if not errors
     @model.save({}, 
       wait: true
       success: -> 
         
         self.notify("Card was saved successfully")
         
         
         self.enableButtons()
         self.onFormClean()
         
       error:(model, xhr, options) ->
         
         self.saveBtn.resetState()
         
         errors = []
         for k, v of JSON.parse(xhr.responseText)
           errors.push(k + " " + v)
         
         
         self.notify(errors.join(", "), 1)
       )
  
  cleanForm: ->
    @form.remove()
    @renderForm()
    @onFormClean()
    
  renderForm: ->
    @$("div.card_edit").html(@form.render().el)
    @$("div.card-number").text(@form.getFormattedNumber())
    @$("div.card-name").text(@form.fields.nameOnCard.getValue())
  
  onFormDirty: ->
    if @produceBtn
      @produceBtn.disable()
      
    if @printCardBtn
      @printCardBtn.disable()
      
    if @printReceiptBtn
      @printReceiptBtn.disable()
      
    @saveBtn.enable()
    @resetBtn.enable()
  
  
  disableButtons: ->
    
    for b in @buttons
      b.disable()
      
  enableButtons: ->
    for b in @buttons
      b.enable()
  
  onFormClean: ->
    
    if @produceBtn
      @produceBtn.enable()

    if @printCardBtn
      @printCardBtn.enable()

    if @printReceiptBtn
      @printReceiptBtn.enable()
   
    @saveBtn.resetState()
    self = @
    self.saveBtn.disable()
    setTimeout((-> self.saveBtn.disable()), 1) #workaround since bootstrap for some reason sets timeout for reseting button
    @resetBtn.disable()

  getActions: ->

    buttonsWrapper = $("<div />");
    
    @saveBtn = new com.tgalal.backbonents.buttons.Button(text: "Save changes", loadingText: "Saving...")
    @saveBtn.render()
    @saveBtn.disable()
    @saveBtn.on("clicked", @onSaveClicked, @ )
    
    
    @resetBtn = new com.tgalal.backbonents.buttons.Button(text: "", icon: "refresh", className="dropdown-toggle")
    @resetBtn.render()
    @resetBtn.disable()
    @resetBtn.on('clicked', @cleanForm, @)
    
    
    
    @cancelBtn = new com.tgalal.backbonents.buttons.Button(text: "", type: 2, icon: "remove", loadingText: "..", completeText: "")
    @cancelBtn.render()
    @cancelBtn.on("clicked", @onCancel, @)
    
    
    @buttons = [@saveBtn, @resetBtn, @cancelBtn]

    switch @model.get('status_id')
      when 1
      
        buttonsWrapper.append($("<div />").addClass("btn-group").append(@saveBtn.el).append(@resetBtn.el))
      
        @produceBtn = new com.tgalal.backbonents.buttons.Button(text: "Produce", loadingText: "Producing", completeText: "Produced")
        @produceBtn.bind "clicked", @onProduce, @
        
        @buttons.push(@produceBtn)

        buttonsWrapper.append(@produceBtn.render().el)
        
        
        buttonsWrapper.append(@cancelBtn.el)

      when 2
        buttonsWrapper.append($("<div />").addClass("btn-group").append(@saveBtn.el).append(@resetBtn.el))
        
        @printReceiptBtn = new com.tgalal.backbonents.buttons.Button(text: "Print Receipt", icon: "print")
        @printReceiptBtn.bind "clicked", @onProduce, @

        @buttons.push(@printReceiptBtn)

        buttonsWrapper.append(@printReceiptBtn.render().el)

        @printCardBtn = new com.tgalal.backbonents.buttons.Button(text: "Print Card", icon: "file", type: 3)
        @printCardBtn.bind "clicked", @onCancel, @
        
        @buttons.push(@printCardBtn)
        
        buttonsWrapper.append(@printCardBtn.render().el)

        buttonsWrapper.append(@cancelBtn.el)
    ###
      when 3
        @kConfirmBtn = new com.tgalal.backbonents.buttons.Button(text: "Kiwi Confirm", type: 3)
        @kConfirmBtn.bind "clicked", @onProduce, @
        
        buttonsWrapper.append(@kConfirmBtn.render().el)#.html(buttonsWrapper.html() + " ")
        
        @buttons.push(@kConfirmBtn)
        
        @cConfirmBtn = new com.tgalal.backbonents.buttons.Button(text: "Courier Confirm")
        @cConfirmBtn.bind "clicked", @onCancel, @
        
        buttonsWrapper.append(@cConfirmBtn.render().el)#.html(buttonsWrapper.html() + " ")
        
        @buttons.push(@cConfirmBtn)
        
        buttonsWrapper.append(@cancelBtn.el)#.html(buttonsWrapper.html() + " ")
     ###
    
    return buttonsWrapper


  onCancel: ->
    @confirmDialog.off("accepted")
    @confirmDialog.on("accepted", @doCancel, @)
    @confirmDialog.show("Send card to limbo ?")
    
  
  doCancel: ->
    @confirmDialog.hide();
    self = @

    self.cancelBtn.setLoadingState()
    
    @model.save({"status_id": 5, "batch_id": null}, 
      
      success:(model, response, options)->
        
        self.notify("Card sent to limbo")
        
        self.cancelBtn.setCompleteState();
        
        self.disableButtons()
     
      error:(model, xhr, options) ->
        
        self.notify("An error occured", 1)
        
        self.cancelBtn.resetState()
        
        self.enableButtons()
        
        
        
        )

  onProduce: ->
    @confirmDialog.off("accepted")
    @confirmDialog.on("accepted", @doProduce, @)
    @confirmDialog.show("Send card to production ?")
  
  doProduce: ->
    @confirmDialog.hide();
    
    @disableButtons()
    
    @produceBtn.setLoadingState()
    
    batch = new Kworkflow.Models.Batch()
    
    self = @
    batch.save({card: [@model]}, 
      success: (model, response, options) ->
          
        self.model.set("status_id", 2)
        
        self.model.trigger("sync")
        
        self.notify("Card successfully sent to production")

        self.produceBtn.setCompleteState()
        #self.produceBtn.resetState();
        self.saveBtn.disable()
        self.cancelBtn.disable()
      error:(model, xhr, options) ->
        
        self.enableButtons()

        errors = []
        for k, v of JSON.parse(xhr.responseText)
         errors.push(k + " " + v)
 
 
        self.notify(errors.join(", "), 1)
        
        )
    
    
  
  _render: ->
    
    startDate = new Date( Date.parse @model.get('created_at'))
    
    startMonth = startDate.getMonth() + 1
    startYear = startDate.getFullYear() - 2000
    startMonth = "0" + startMonth if startMonth < 10
    
    endDate = new Date( Date.parse @model.get('created_at'))
    endDate.setMonth(endDate.getMonth() + @model.get('card_type').expirationMonths)
    
    endMonth = endDate.getMonth() + 1
    
    endMonth = "0" + endMonth if endMonth < 10
    
    endYear = endDate.getFullYear() - 2000
    
    
    super(card: @model, startMonth: startMonth, startYear: startYear, endMonth: endMonth, endYear: endYear)
    
    
    fields = ["number", "nameOnCard"]
    
    @form = new Backbone.Form({
          model: @model
          fields: fields
      }).render();
    
    @form.on('change', @onFormDirty, @)
    
    @form.getFormattedNumber = ->
            
      n = @.fields.number.getValue();
        
      p1 = ""
      p2 = ""
      p3 = ""
      p4 = ""
      
      p1 = n.substr(0,4)
      
      if p1
        p2 = n.substr(4, 4)
        
        if p2
          p3 = n.substr(8, 4)
          
          if p3
            p4 = n.substr(12, 4)
      
      
      p1 + " " + p2 + " " + p3 + " " + p4

    self = @

    @form.on('number:change', (form, field) -> self.$("div.card-number").text(form.getFormattedNumber())) 
    @form.on('nameOnCard:change', (form, field) -> self.$("div.card-name").text(field.getValue()) )
    
    if @model.get('status_id') < 3
      @renderForm()
    else
      @$("div.card-number").text(@form.getFormattedNumber())

    # actions
    

    @$(@actionsEl).html('')
    
    
    if typeof(@actionsEl) == "string"    
      @$(@actionsEl).html(@getActions());
    else
      @actionsEl.html(@getActions());
    
    
    
    
    @confirmDialog = new com.tgalal.backbonents.dialogs.ConfirmDialog el: @$(".confirm_modal");
    @confirmDialog.render()
    
