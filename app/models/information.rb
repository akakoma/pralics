class Information < ApplicationRecord
  validates :body, presence: true
  validates :title, presence: true
  mount_uploader :image, ImageUploader
end
