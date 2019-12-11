class CreateReservation < ActiveRecord::Migration[5.2]
  def up
    create_table :reservations do |t|
      t.references :user, foreign_key: true
      t.references :planner, foreign_key: true
      t.string :description, limit: 200

      t.datetime :scheduled_at, null: false

      t.timestamps
    end
  end

  def down
    drop_table :reservations
  end
end
