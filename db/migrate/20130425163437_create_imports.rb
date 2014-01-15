class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.string :name
      t.string :originalName
      t.boolean :deleted, :null => false, :default => false
      t.boolean :isValid,  :null => false, :default => false
      t.integer :type_id

      t.timestamps
    end
  end
end
