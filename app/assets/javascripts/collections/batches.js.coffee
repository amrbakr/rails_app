class Kworkflow.Collections.Batches extends Backbone.Paginator.requestPager
  model: Kworkflow.Models.Batch
  status_id: 2
  


  url: -> '/batches'
  
  
  paginator_core:
      # the type of the request (GET by default)
      type: 'GET',

      # the type of reply (jsonp by default)
      dataType: 'json',

      # the URL (or base URL) for the service
      # if you want to have a more dynamic URL, you can make this a function
      # that returns a string
      url: -> '/batches'
      
  
  paginator_ui:
    firstPage: 0
    currentPage: 0
    perPage: 20
    
    #totalPages: 10
    
    #totalRecords: 50
  
  parse: (response) ->
     @totalRecords = response.total
     
     @totalPages = Math.ceil(@totalRecords/@perPage)
     
     if @totalPages  == 0
       @totalPages = 1

     response.batches
  
  server_api:
    $filter: ''
    
    top: ->  
      @perPage
      
    skip: ->
      @currentPage * @perPage
      
    status_id : ->
       @status_id
  