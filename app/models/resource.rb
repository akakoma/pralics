class Resource < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
end
