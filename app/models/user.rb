class User < ApplicationRecord
  validates :name, :address, :email, presence: true
  has_one_attached :avatar
  has_secure_password
  attr_accessor :remember_token
  has_many :books, as: :belonger, dependent: :destroy
  accepts_nested_attributes_for :books, allow_destroy: true

  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address

  before_save { self.email.downcase! }

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
    self.remember_token = User.generate_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Check if the given value matches the one stored in DB
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def main_address
    address = self.address
    return "#{address.detail}, #{address.street}, #{address.district}, #{address.city}"
  end
end
