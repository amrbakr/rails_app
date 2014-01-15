class Kworkflow.Collections.Cards extends Backbone.Collection
  
  initialize: (options)->
    @status_id = options.status_id
  
  url: -> '/cards/status/' + @status_id
  model: Kworkflow.Models.Card


class Kworkflow.Collections.XCards extends Backbone.Collection
  
  model: Backbone.Model
  
  #batchTitle: ""
  
  #toJSON: ->
  #  cards: super()
  
  produce:(batchTitle, options) ->
    Backbone.sync('create', @, 
      url: "/batches"
      data: JSON.stringify(card: @toJSON(), batch: {title: batchTitle})
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

class Kworkflow.Collections.PaginatedCards extends Backbone.Paginator.requestPager
  model: Kworkflow.Models.Card
  url: -> '/cards/status/' + @status_id
  
  
  paginator_core:
      # the type of the request (GET by default)
      type: 'GET',

      # the type of reply (jsonp by default)
      dataType: 'json',

      # the URL (or base URL) for the service
      # if you want to have a more dynamic URL, you can make this a function
      # that returns a string
      url: -> '/cards/status/' + @status_id
      
  
  paginator_ui:
    firstPage: 0
    currentPage: 0
    perPage: 5
    
    #totalPages: 10
    
    #totalRecords: 50
  
  parse: (response) ->
     @totalRecords = response.total
     
     @totalPages = Math.ceil(@totalRecords/@perPage)
     
     if @totalPages  == 0
       @totalPages = 1
     
     response.cards
  
  server_api:
    $filter: ''
    
    top: ->  
      @perPage
      
    skip: ->
      @currentPage * @perPage
      
  initialize: (options)->
    @status_id = options.status_id
  