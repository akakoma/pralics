class AddCompanyCountToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :company_count, :integer
  end
end
