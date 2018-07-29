class Company < ApplicationRecord
  has_secure_password

   has_one_attached :avatar

  validates :name, presence: true,uniqueness: true
  validates :genre, presence: true
  validates :email, presence: true
  validates :password_digest, presence: true
  validates :manager, presence: true
  validates :tel, presence: true
  validates :body, presence: true
  validates :company_info, presence: true
  validates :name, :uniqueness => {:scope => :password_digest}
end
