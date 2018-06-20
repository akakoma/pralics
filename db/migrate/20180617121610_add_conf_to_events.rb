class AddConfToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :conf, :string
  end
end
