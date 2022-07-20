class AddDetailToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :belonger_type, :string
    add_column :books, :belonger_id, :integer
    add_column :books, :returned_date, :datetime
    add_column :books, :description, :text

    remove_reference :books, :user, index: true, foreign_key: true
    remove_column :books, :price
  end
end
