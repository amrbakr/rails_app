class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstName
      t.string :lastName
      t.string :email
      t.date :dob
      t.string :mobile
      t.timestamps
    end
  end
end
