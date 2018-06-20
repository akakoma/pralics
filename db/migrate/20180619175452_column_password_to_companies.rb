class ColumnPasswordToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :password_digest, :string
    remove_column :companies, :password, :string
  end
end
