class User < ApplicationRecord
  has_secure_password

  mount_uploader :image, ImageUploader
  validates :name, presence: true
  validates :user_id, presence: true,uniqueness: true
  validates :email, presence: true,uniqueness: true
  validates :password_digest, presence: true
  validates :image, presence: true
  validates :sex, presence: true
  validates :age, presence: true
  validates :user_info, presence: true
  validates :body, presence: true
  validates :user_id, :uniqueness => {:scope => :password_digest}

  has_many :usersubgroups

end
