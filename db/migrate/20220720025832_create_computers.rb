class CreateComputers < ActiveRecord::Migration[7.0]
  def change
    create_table :computers do |t|
      t.string :place
      t.boolean :in_used

      t.timestamps
    end
  end
end
