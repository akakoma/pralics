class AddEventToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :timing, :integer
  end
end
