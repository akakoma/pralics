class Contact < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :title, presence: true
  validates :message, presence: true
  validates :reply, presence: true
end
