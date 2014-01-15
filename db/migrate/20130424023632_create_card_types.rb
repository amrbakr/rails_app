class CreateCardTypes < ActiveRecord::Migration
  def change
    create_table :card_types do |t|

      t.string :title
      t.integer :expirationMonths
      t.boolean :isDefault
      t.boolean :premium

      t.timestamps
    end
    
    change_table :cards do |t|
      t.integer :type_id
    end
    
  end
end
