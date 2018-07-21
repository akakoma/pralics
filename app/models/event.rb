class Event < ApplicationRecord
  validates :title, presence: true
  validates :image, presence: true
  validates :place, presence: true
  validates :time, presence: true
  validates :day, presence: true
  validates :genre, presence: true
  validates :company_id, presence: true
  validates :user_count, presence: true
  validates :company_count, presence: true
  validates :likes_count, presence: true

  validates :title, length: { maximum: 36 }
end
