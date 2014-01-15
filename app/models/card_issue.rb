class CardIssue < ActiveRecord::Base
  attr_accessible :active, :endDate, :startDate, :title
  
  has_many :card, :foreign_key => "issue_id"
  
  def toString
    "#{title}"
  end
  
end
