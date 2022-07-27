class Staff < ApplicationRecord
  attr_accessor :remember_token
  has_secure_password
  has_many :addresses, dependent: :destroy
  has_one_attached :avatar
  accepts_nested_attributes_for :addresses, allow_destroy: true
  validates :name, :email, presence: true

  before_create :set_role_default
  before_save { self.email.downcase! }
  enum role: { admin: 0, librarian: 1, cleaner: 2 }

  def main_address
    address = self.addresses.find_by(main: true)
    return "#{address.detail}, #{address.street}, #{address.district}, #{address.city}"
  end

  class << self
    # Return the hash value of the given string
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Return a random token
    def generate_token
      SecureRandom.urlsafe_base64
    end
  end

  # Create a new token -> encrypt it -> stores the hash value in remember_digest in DB.
  def remember
    self.remember_token = Staff.generate_token
    update_attribute(:remember_digest, Staff.digest(remember_token))
  end

  # Check if the given value matches the one stored in DB
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def able_to_return?
    self.admin? || self.librarian?
  end

  private

  def set_role_default
    if self.role.blank?
      self.role = "librarian"
    end
  end
end
