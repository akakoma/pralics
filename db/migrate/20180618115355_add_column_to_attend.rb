class AddColumnToAttend < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :group_info, :integer
    add_column :attends, :group_info, :integer
  end
end
