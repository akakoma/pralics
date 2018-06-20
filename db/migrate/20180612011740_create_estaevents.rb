class CreateEstaevents < ActiveRecord::Migration[5.2]
  def change
    create_table :estaevents do |t|
      t.string :title
      t.string :place
      t.string :image
      t.string :price
      t.text :body
      t.string :time
      t.string :day
      t.string :genre
      t.integer :event_id
      t.integer :group_id

      t.timestamps
    end
  end
end
