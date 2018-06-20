class AddReviewToEstaevent < ActiveRecord::Migration[5.2]
  def change
    add_column :estaevents, :review, :text
  end
end
