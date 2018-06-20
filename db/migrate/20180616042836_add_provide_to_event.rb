class AddProvideToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :provide, :string
  end
end
