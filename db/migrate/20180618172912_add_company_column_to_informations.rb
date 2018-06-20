class AddCompanyColumnToInformations < ActiveRecord::Migration[5.2]
  def change
    add_column :information, :company_id, :integer
  end
end
