class Cardbatchid < ActiveRecord::Migration
  def up
    change_table :cards do |t|
      t.integer :batch_id
    end
  end
  
  def down
    remove_column :cards, :batch_id
  end
end
