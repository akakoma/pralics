class RemoveEstaeventIdToAttends < ActiveRecord::Migration[5.2]
  def change
    remove_column :attends, :estaevent_id, :integer
  end
end
