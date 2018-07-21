class Estaevent < ApplicationRecord
  validates :title, presence: true
  validates :image, presence: true
  mount_uploader :image, ImageUploader
  validates :genre, presence: true
  validates :event_id, presence: true
  validates :company_id, presence: true
  validates :user_count, presence: true
  validates :company_count, presence: true
  validates :title, length: { maximum: 36 }
end
