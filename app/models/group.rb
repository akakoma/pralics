class Group < ApplicationRecord


  validates :name, presence: true
  validates :image, presence: true
  mount_uploader :image, ImageUploader
  validates :genre, presence: true
  validates :group_type, presence: true
  validates :sub_password, presence: true
  validates :mana_password, presence: true

  validates :name, :uniqueness => {:scope => :sub_password}

end
