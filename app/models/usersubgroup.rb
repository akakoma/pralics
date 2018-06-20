class Usersubgroup < ApplicationRecord
  validates :group_id, presence: true
  validates :user_id, presence: true
  validates :user_id, :uniqueness => {:scope => :group_id}
  belongs_to :user
end
