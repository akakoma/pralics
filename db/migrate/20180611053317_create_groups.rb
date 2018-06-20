class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :image
      t.string :name
      t.string :genre
      t.string :type
      t.string :format
      t.string :sub_password
      t.string :mana_password

      t.timestamps
    end
  end
end
