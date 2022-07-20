class AddDetailToComputers < ActiveRecord::Migration[7.0]
  def change
    add_column :computers, :setting, :text
    add_column :computers, :price, :float
  end
end
