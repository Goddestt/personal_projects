class Staff < ApplicationRecord
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true
  validates :name, :addresses, :email, presence: true

  before_create :set_role_default

  enum role: { admin: 0, librarian: 1, cleaner: 2 }

  def main_address
    address = self.addresses.find_by(main: true)
    return "#{address.detail}, #{address.street}, #{address.district}, #{address.city}"
  end

  validate :check_main_address, if: -> { !self.addresses.blank? }

  private

  def set_role_default
    if self.role.blank?
      self.role = "librarian"
    end
  end

  def check_main_address
    return !self.addresses.find_by(main: true).blank?
  end
end
