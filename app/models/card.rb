class Card < ActiveRecord::Base
 
 attr_accessible :nameOnCard, :number,:user_id, :batch_id, :type_id, :expirationDate, :subscriptionDate, :expired, :sanityChecked, :called, :status_id, :locked
 
 belongs_to :user
 belongs_to :batch
 belongs_to :card_type, :foreign_key => "type_id"
 belongs_to :card_issue, :foreign_key => "issue_id"
 belongs_to :card_status, :foreign_key => "status_id"
 
 validates :number, :length => { 
    :is => 16,
    :too_long  => "must be %{count} digits",
    :too_short  => "must be %{count} digits"
    
    },
    :presence => true,
    :uniqueness => true
    
    
    def save
      
      if self.number == nil || self.number.empty?
        #assign a uniquenumber
        
        self.number = "UNIQUE_NUMBER"
        
      end

      super
      
      
    end
 
end
