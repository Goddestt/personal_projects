class Book < ApplicationRecord
  belongs_to :belonger, polymorphic: true
  has_one_attached :cover_image
  validates :belonger, :name, :barcode, :author, presence: true
  validates :barcode, uniquess: true
end
