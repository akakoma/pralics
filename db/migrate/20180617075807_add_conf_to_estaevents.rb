class AddConfToEstaevents < ActiveRecord::Migration[5.2]
  def change
    add_column :estaevents, :conf, :string
  end
end
