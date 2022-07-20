class Computer < ApplicationRecord
  validates :setting, :price, :place, presence: true
end
