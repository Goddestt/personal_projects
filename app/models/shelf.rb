class Shelf < ApplicationRecord
  has_many :books, as: :belonger, dependent: :destroy
  accepts_nested_attributes_for :books, allow_destroy: true
end
