class Message < ApplicationRecord
  validates :to_name, presence: true
  validates :from_name, presence: true
  validates :room_id, presence: true
  mount_uploader :image, ImageUploader
  validates :image, presence: true, uniqueness: true, :allow_nil => true ,if: -> { text.blank? }
  validates :text , presence: true ,if: -> { image.blank? }
end
