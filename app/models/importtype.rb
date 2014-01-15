class Importtype < ActiveRecord::Base
  #attr_accessible :description, :enabled, :extension, :mimetype, :name
  
  has_many :import, :foreign_key => "type_id"
  
end
