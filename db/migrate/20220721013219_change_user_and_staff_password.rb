class ChangeUserAndStaffPassword < ActiveRecord::Migration[7.0]
  def change
    remove_column :staffs, :password
    add_column :staffs, :password_digest, :string
    remove_column :users, :password
    add_column :users, :password_digest, :string
  end
end
