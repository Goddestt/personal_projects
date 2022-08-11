class RemoveMainFromAddresses < ActiveRecord::Migration[7.0]
  def change
    remove_column :addresses, :main, :boolean
  end
end
