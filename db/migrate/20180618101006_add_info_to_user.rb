class AddInfoToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_info, :integer
    add_column :users, :group_info, :integer 
  end
end
