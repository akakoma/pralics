class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :to_name
      t.string :form_name
      t.text :text
      t.string :room_id

      t.timestamps
    end
  end
end
