class Kworkflow.Models.Card extends Backbone.Model
  urlRoot: "/cards"
  namespace: "card"
  #toJSON: ->
  #  card: Backbone.Model.prototype.toJSON.apply(@, arguments);
  
  schema: 
    nameOnCard: 'Text'
    number: 'Text'
    status_id:
      type: 'Select',
      options: [{val:1, label: "Pending"}, {val:2, label:'Production'}]
      
    called: "Checkbox",
    sanityChecked: "Checkbox"
