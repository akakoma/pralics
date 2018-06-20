class ColumnPasswordToManagers < ActiveRecord::Migration[5.2]
  def change
    add_column :managers, :password_digest, :string
    remove_column :managers, :password, :string
  end
end
