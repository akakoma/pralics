class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :genre
      t.string :email
      t.string :password
      t.string :manager
      t.integer :tel

      t.timestamps
    end
  end
end
