class Book < ApplicationRecord
  belongs_to :belonger, polymorphic: true
  has_one_attached :cover_image

  has_one :page, dependent: :destroy
  accepts_nested_attributes_for :page

  validates :belonger, :name, :barcode, :author, presence: true
  validates :barcode, uniqueness: true

  def is_borrowed?
    self.belonger.is_a? User
  end

  def pdf_preview
    WickedPdf.new.pdf_from_string(self.page.content.to_plain_text)
  end
end
