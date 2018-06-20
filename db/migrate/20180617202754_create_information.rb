class CreateInformation < ActiveRecord::Migration[5.2]
  def change
    create_table :information do |t|
      t.text :body
      t.string :title
      t.integer :user_id
      t.integer :group_id
      t.string :image

      t.timestamps
    end
  end
end
