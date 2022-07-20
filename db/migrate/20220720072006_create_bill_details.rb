class CreateBillDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :bill_details do |t|
      t.integer :bill_id
      t.integer :book_id
      t.float :price

      t.timestamps
    end
  end
end
