class CreatePlanner < ActiveRecord::Migration[5.2]
  def up
    create_table :planners do |t|
      t.string :name, null: false, limit: 50
      t.string :email, null: false, limit: 100
      t.string :password_digest, null: false
      t.timestamp

      t.index :email, unique: true
    end
  end

  def down
    drop_table :planners
  end
end
