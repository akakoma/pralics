class RenameFormNameToMessages < ActiveRecord::Migration[5.2]
  def change
    rename_column :messages,:form_name,:from_name 
  end
end
