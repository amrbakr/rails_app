class Printconfirms < ActiveRecord::Migration
  def up
    change_table :cards do |t|
      t.boolean :printed
      t.boolean :receiptPrinted
    end
  end

  def down
    remove_column :cards, :printed
    remove_column :cards, :receiptPrinted
  end
end
