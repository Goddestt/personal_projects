class AddUserIdToAddress < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :staff_id, :integer
    add_column :addresses, :user_id, :integer
  end
end
