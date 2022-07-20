class Address < ApplicationRecord
  validates :detail, :district, :street, :city, presence: true
end
