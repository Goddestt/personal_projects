class CreateStaffs < ActiveRecord::Migration[7.0]
  def change
    create_table :staffs do |t|
      t.string :name
      t.string :email
      t.string :password
      t.integer :role

      t.timestamps
    end
  end
end
