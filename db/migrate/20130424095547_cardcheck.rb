class Cardcheck < ActiveRecord::Migration
  def up
    change_table :cards do |t|
      t.boolean :sanityChecked
      t.boolean :called
    end
  end

  def down
    remove_column :cards, :sanityChecked
    remove_column :cards, :called
  end
end
