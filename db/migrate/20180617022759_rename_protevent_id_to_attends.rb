class RenameProteventIdToAttends < ActiveRecord::Migration[5.2]
  def change
    rename_column :attends, :protevent_id, :estaevent_id
  end
end
