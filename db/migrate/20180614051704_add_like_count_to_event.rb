class AddLikeCountToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :likes_count, :integer
  end
end
