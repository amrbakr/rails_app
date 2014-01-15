class CardType < ActiveRecord::Base
  attr_accessible :title, :expirationMonths, :isDefault, :premium
  
  has_many :card, :foreign_key => "type_id"
  
  
  def toString
    "#{title} (#{expirationMonths} months)"
  end
end
