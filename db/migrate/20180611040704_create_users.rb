class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :user_id
      t.string :email
      t.integer :organizer_id
      t.string :image

      t.timestamps
    end
  end
end
