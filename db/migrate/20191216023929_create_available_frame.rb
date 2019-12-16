class CreateAvailableFrame < ActiveRecord::Migration[5.2]
  def up
    create_table :available_frames do |t|
      t.references :planner, foreign_key: true
      t.datetime :scheduled_time, null: false, comment: "予約可能な日時と開始時間"
      t.timestamps

      t.index [:planner_id, :scheduled_time], unique: true
    end
  end

  def down
    drop_table :avaliable_frames
  end
end
