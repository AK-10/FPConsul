class CreateUser < ActiveRecord::Migration[5.2]
  def up
    create_table :users do |t|
      t.string :name, null: false, limit: 50
      t.string :email, null: false, limit: 319
      t.string :password_digest, null: false 
      t.timestamps
    end
  end
  def down
    drop_table :users
  end
end

