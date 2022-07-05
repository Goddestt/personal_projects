class User < ApplicationRecord
  validates :name, presence: true
  has_many_attached :images
  has_one_attached :avatar
end
