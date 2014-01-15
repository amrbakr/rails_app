class Batchprops < ActiveRecord::Migration
  def up
    change_table :batches do |t|
      t.string :title
    end
  end
  
  def down
    remove_column :batches, :title
  end
end
