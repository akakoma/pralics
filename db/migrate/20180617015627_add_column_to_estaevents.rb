class AddColumnToEstaevents < ActiveRecord::Migration[5.2]
  def change
    add_column :estaevents, :room_id, :string
    add_column :estaevents, :user_id, :integer
    add_column :estaevents, :company_id, :integer
  end
end
