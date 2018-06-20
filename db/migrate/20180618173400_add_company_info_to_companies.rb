class AddCompanyInfoToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :company_info, :integer
  end
end
