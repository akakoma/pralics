class RemoveTimingToEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :timing, :integer
  end
end
