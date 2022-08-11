class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.integer :book_id
      t.integer :position
      t.text :content

      t.timestamps
    end
  end
end
