class com.tgalal.backbonents.routers.DemoRouter extends Backbone.Router

  routes:
    '': 'runDemo'

  runDemo :->
    console.log('aho')
    d = new com.tgalal.backbonents.misc.Demo el: "#app_root"
    console.log('rendering')
    d.render()