class AddRememberDigestToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :remember_digest, :string
    add_column :staffs, :remember_digest, :string
  end
end
