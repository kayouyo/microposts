class AddAnimalToUsers < ActiveRecord::Migration
  def change
    add_column :users, :animal, :string
  end
end
