class UserCards < ActiveRecord::Migration
  def up
    change_table :cards do |t|
      t.integer :user_id
    end
  end

  def down
    remove_column :cards, :user_id
  end
end
