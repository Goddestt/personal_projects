class ChangeAddessToAddress < ActiveRecord::Migration[7.0]
  def change
    rename_table :addesses, :addresses
  end
end
