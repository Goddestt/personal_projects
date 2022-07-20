class BillDetail < ApplicationRecord
  validates :book_id, :bill_id, :price, presence: true
end
