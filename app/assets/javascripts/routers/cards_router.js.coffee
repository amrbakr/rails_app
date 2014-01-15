class Kworkflow.Routers.Cards extends Backbone.Router
  routes:
    '' : 'showPending'
    'check': 'showPending'
    'production': 'showProduction'
    'shipments': 'showShipments'


  initialize: ->
    
    @appPane = new com.tgalal.backbonents.panes.Pane el: "#cards_root"
    @appPane.render()

  showPending: ->
    window.setSubmenuItem("check")
    @appPane.show(new Kworkflow.Views.Pages.PendingPage)

  showProduction :->
    window.setSubmenuItem("production")
    @appPane.show(new Kworkflow.Views.Pages.ProductionPage)
    
  showShipments :->
    window.setSubmenuItem("shipments")
    @appPane.show(new Kworkflow.Views.Pages.ShipmentPage)
  
  