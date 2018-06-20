class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :image
      t.string :place
      t.integer :top_price
      t.integer :bottom_price
      t.text :body
      t.integer :top_people
      t.integer :bottom_people
      t.string :time
      t.string :day
      t.string :genre
      t.integer :organizer_id
      t.integer :company_id

      t.timestamps
    end
  end
end
