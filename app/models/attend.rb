class Attend < ApplicationRecord
  validates :estaevent_id, presence: true
  validates :user_id, presence: true
  validates :user_id, :uniqueness => {:scope => :estaevent_id}

end
