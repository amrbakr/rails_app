class CreateCardIssues < ActiveRecord::Migration
  def change
    create_table :card_issues do |t|
      t.string :title
      t.date :startDate
      t.date :endDate
      t.boolean :active

      t.timestamps
    end
    
    change_table :cards do |t|
      t.integer :issue_id
    end
    
  end
end
