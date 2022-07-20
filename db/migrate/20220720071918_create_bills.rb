class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.integer :staff_id
      t.integer :user_id
      t.float :discount
      t.float :total_price
      t.float :actual_price

      t.timestamps
    end
  end
end
