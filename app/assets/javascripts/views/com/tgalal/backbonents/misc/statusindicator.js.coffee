class com.tgalal.backbonents.misc.StatusIndicator extends com.tgalal.backbonents.core.Widget
  
  #workingTemplate: "com/tgalal/backbonents/misc/workingindicator"
  #normalTemplate: "com/tgalal/backbonents/misc/workingindicator"
  
  workingText: "Working"

  setNormal:->
    $(@el).html('')

  setWorking:(text)->
    console.log("RENDERING")
    #$(@el).html(@workingTemplate(title: text or @workingText))
    notif = new com.tgalal.backbonents.notifications.InfoNotification el:@el
    notif.title = text or @workingText
    notif.render()