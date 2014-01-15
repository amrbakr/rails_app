class CardStatus < ActiveRecord::Base
  attr_accessible :title
  
  has_many :card, :foreign_key => "status_id"
  
end
