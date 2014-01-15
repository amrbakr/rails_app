class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :amount
      t.string :number
      t.date :subscriptionDate
      t.date :expirationDate
      t.boolean :expired

      t.timestamps
    end
  end
end
