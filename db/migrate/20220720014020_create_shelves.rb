class CreateShelves < ActiveRecord::Migration[7.0]
  def change
    create_table :shelves do |t|
      t.string :place
      t.integer :row_number

      t.timestamps
    end
  end
end
