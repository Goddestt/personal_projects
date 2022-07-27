class AddPhoneNumberToStaff < ActiveRecord::Migration[7.0]
  def change
    add_column :staffs, :phone_number, :string
  end
end
