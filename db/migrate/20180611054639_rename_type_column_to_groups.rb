class RenameTypeColumnToGroups < ActiveRecord::Migration[5.2]
  def change
    rename_column :groups, :type, :group_type
  end
end
