class Nameoncard < ActiveRecord::Migration
  def up
    change_table :cards do |t|
      t.string :nameOnCard
    end
  end

  def down
    remove_column :cards, :nameOnCard
  end
end
