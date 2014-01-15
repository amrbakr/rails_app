class Batch < ActiveRecord::Base
   attr_accessible :title
   validates :title, :uniqueness => true
   
   has_many :card
   
end
