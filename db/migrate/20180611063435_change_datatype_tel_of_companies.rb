class ChangeDatatypeTelOfCompanies < ActiveRecord::Migration[5.2]
  def change
    change_column :companies,:tel,:string
  end
end
