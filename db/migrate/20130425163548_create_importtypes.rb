class CreateImporttypes < ActiveRecord::Migration
  def change
    create_table :importtypes do |t|
      t.string :name
      t.string :description
      t.string :extension
      t.boolean :enabled
      t.string :mimetype

      t.timestamps
    end
  end
end
