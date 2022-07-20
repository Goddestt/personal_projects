class User < ApplicationRecord
  validates :name, :addresses, :email, presence: true
  has_one_attached :avatar

  has_many :books, as: :belonger, dependent: :destroy
  accepts_nested_attributes_for :books, allow_destroy: true

  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true

  validate :check_main_address, if: -> { !self.addresses.blank? }

  private

  def main_address
    address = self.addresses.find_by(main: true)
    return "#{address.detail}, #{address.street}, #{address.district}, #{address.city}"
  end
end
