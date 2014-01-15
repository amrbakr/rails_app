class CreateCardStatuses < ActiveRecord::Migration
  def change
    create_table :card_statuses do |t|
      t.string :title

      t.timestamps
    end
    
   change_table :cards do |t|
     t.integer :status_id
   end
    
  end
end
