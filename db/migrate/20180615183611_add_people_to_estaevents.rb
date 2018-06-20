class AddPeopleToEstaevents < ActiveRecord::Migration[5.2]
  def change
    add_column :estaevents, :people, :integer
  end
end
