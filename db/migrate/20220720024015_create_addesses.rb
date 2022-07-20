class CreateAddesses < ActiveRecord::Migration[7.0]
  def change
    create_table :addesses do |t|
      t.string :detail
      t.string :street
      t.string :district
      t.string :city
      t.boolean :main

      t.timestamps
    end
  end
end
