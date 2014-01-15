class User < ActiveRecord::Base
  
  attr_accessible :firstName, :lastName, :email
  
  has_many :cards
  
  validates :email, :presence => true, :uniqueness => true
  validates :firstName, :presence => true
  validates :lastName, :presence => true

end
