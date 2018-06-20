class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.text :message
      t.string :title
      t.string :name
      t.string :email
      t.string :reply

      t.timestamps
    end
  end
end
