class Kworkflow.Models.Batch extends Backbone.Model
  urlRoot: "/batches"
  
  
  confirmPrint: (printType, options) -> #0 card #1 receipt
    self = @
    @sync('update', @, 
      url: "/batches/"+@id+ "/print"
      data: JSON.stringify(t: printType)
      contentType: "application/json"
      
      success: ->
        if printType == 1
          self.set("receiptPrinted", true)
        else
          self.set("printed", true)
          
        options.success() if options.success()
      
      error:(e) ->
        if options.error
          
          if "json" in e.getResponseHeader("content-type")
            res = JSON.parse(e.responseText)
          else
            res = e.responseText
          options.error(e.status, e.statusText, res)
    )
  
  ship: (options) ->
    Backbone.sync('create', @, 
      url: "/batches/" + @id + "/ship"
      #data: JSON.stringify(id: @id)
      contentType: 'application/json'
        
      success: ->
        if options.success
          options.success()
      error: (e) ->

        if options.error
          
          if "json" in e.getResponseHeader("content-type")
            res = JSON.parse(e.responseText)
          else
            res = e.responseText
          options.error(e.status, e.statusText, res)
    )
    
  ownConfirm: (options) ->
    self = @
    Backbone.sync('create', @, 
      url: "/batches/" + @id + "/ownConfirm"
      #data: JSON.stringify(id: @id)
      contentType: 'application/json'
        
      success: ->
        
        self.set("kconfirm", true)
        
        if options.success
          options.success()
      error: (e) ->

        if options.error
          
          if "json" in e.getResponseHeader("content-type")
            res = JSON.parse(e.responseText)
          else
            res = e.responseText
          options.error(e.status, e.statusText, res)
    )
  
  cConfirm: (options) ->
    self = @
    Backbone.sync('create', @, 
      url: "/batches/" + @id + "/cConfirm"
      #data: JSON.stringify(id: @id)
      contentType: 'application/json'
        
      success: ->
        self.set("cconfirm", true)
        if options.success
          options.success()
      error: (e) ->

        if options.error
          
          if "json" in e.getResponseHeader("content-type")
            res = JSON.parse(e.responseText)
          else
            res = e.responseText
          options.error(e.status, e.statusText, res)
    )
    
  
  schema: 
    title: 'Text'