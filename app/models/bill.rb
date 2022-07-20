class Bill < ApplicationRecord
  validates :staff_id, :user_id, :total_price, :actual_price, presence: true
end
