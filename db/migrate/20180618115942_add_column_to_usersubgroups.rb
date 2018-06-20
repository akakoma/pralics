class AddColumnToUsersubgroups < ActiveRecord::Migration[5.2]
  def change
    remove_column :attends, :group_info, :integer
    add_column :usersubgroups, :group_info, :integer
  end
end
