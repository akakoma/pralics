class Appsubgroup < ApplicationRecord
  validates :user_id,presence: true
  validates :group_id,presence: true
  validates :user_id, :uniqueness => {:scope => :group_id}

end
