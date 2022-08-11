class Page < ApplicationRecord
  belongs_to :book
  has_rich_text :content
end
