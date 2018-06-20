class AddBodyToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :body, :text
  end
end
