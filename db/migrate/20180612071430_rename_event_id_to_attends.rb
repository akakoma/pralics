class RenameEventIdToAttends < ActiveRecord::Migration[5.2]
  def change
    rename_column :attends, :event_id, :estaevent_id
  end
end
