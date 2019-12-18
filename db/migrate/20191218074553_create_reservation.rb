class CreateReservation < ActiveRecord::Migration[5.2]
  def up
    create_table :reservations do |t|
      t.references :user, foreign_key: true
      t.references :planner, foreign_key: true
      t.datetime :scheduled_time, null: false, comment: '予約枠の日時(開始時間)'
      t.timestamps

      t.index [:planner_id, :scheduled_time], unique: true
    end
  end

  def down
    drop_table :reservations
  end
end
