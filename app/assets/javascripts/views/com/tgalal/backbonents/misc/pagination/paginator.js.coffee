#= require ../../core/widget
class com.tgalal.backbonents.misc.pagination.Paginator extends com.tgalal.backbonents.core.Widget
  template: "misc/pagination/paginator"

  showNext: true
  showPrev: true
  
  events: "click li:not(.disabled, .active) a.page": "onClicked",
  "click li:not(.disabled, .active)  a.next": "onNext",
  "click li:not(.disabled, .active)  a.prev": "onPrev"

  options: "reset": true
  
  onNext: (e) ->
    @collection.nextPage(@options)
  
  onPrev: (e) ->
    @collection.prevPage(@options)
  
  onClicked: (e)->
    requested = $(e.currentTarget).text()
    
    @collection.goTo(requested, @options)

  render: ->
    $(@el).html(@template(collection: @collection, showNext: @showNext, showPrev: @showPrev))