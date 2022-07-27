class Book < ApplicationRecord
  belongs_to :belonger, polymorphic: true
  has_one_attached :cover_image

  validates :belonger, :name, :barcode, :author, presence: true
  validates :barcode, uniqueness: true

  def is_borrowed?
    self.belonger.is_a? User
  end
end
