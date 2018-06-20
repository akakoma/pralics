class ChangeClumnToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :room_id, :string
  end
end
