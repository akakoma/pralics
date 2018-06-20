class RenameEstaeventIdToAttends < ActiveRecord::Migration[5.2]
  def change
    rename_column :attends, :estaevent_id, :protevent_id
  end
end
