class Like < ApplicationRecord
  validates :event_id, presence: true
  validates :user_id, presence: true
  validates :user_id, :uniqueness => {:scope => :event_id}

end
