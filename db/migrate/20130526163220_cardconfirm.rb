class Cardconfirm < ActiveRecord::Migration
  def up
    change_table :cards do |t|
      t.boolean :kconfirm
      t.boolean :cconfirm
    end
  end
  
  def down
    remove_column :cards, :kconfirm
    remove_column :cards, :cconfirm
  end
end
