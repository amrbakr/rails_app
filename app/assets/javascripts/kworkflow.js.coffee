window.Kworkflow =
  Models: {}
  Collections: {}
  Views: {
    Pages: {}
    Lists: {}
    Buttons: {}
  }

  Routers: {}
  initialize: -> 
    #new Kworkflow.Routers.Cards
    #Backbone.history.start()
    
    if window.queuedUrl
      Backbone.history.loadUrl(window.queuedUrl)
    
    if window.Router
      new window.Router
      Backbone.history.start()

$(document).ready ->
  
  sync = Backbone.sync;

  Backbone.sync = (method, model, options) -> 
    options = options or {}
    if (!options.data and model.namespace and (method == 'create'))
      data = {};
      data[model.namespace] = model;
      options.data = JSON.stringify(data);
      options.contentType = 'application/json';
    
    sync.apply(this, arguments);

  Kworkflow.initialize()
