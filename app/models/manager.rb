class Manager < ApplicationRecord
has_secure_password
  validates :name, presence: true
  validates :password_digest, presence: true
  validates :name, :uniqueness => {:scope => :password_digest}
end
