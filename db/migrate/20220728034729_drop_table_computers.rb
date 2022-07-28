class DropTableComputers < ActiveRecord::Migration[7.0]
  def change
    drop_table :computers
  end
end
