class AddCurrentLocationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :current_location, :string
  end
end
