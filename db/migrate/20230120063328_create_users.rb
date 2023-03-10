class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.text :profile
      t.string :profile_image_id
      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
