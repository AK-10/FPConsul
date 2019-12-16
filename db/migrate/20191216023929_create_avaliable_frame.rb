class CreateAvaliableFrame < ActiveRecord::Migration[5.2]
  def up
    create_table :avaliable_frames do |t|
      t.references :planner, foreign_key: true
      t.datetime :date_time, comment: "予約可能な日時と開始時間"
      t.timestamps

      t.index [:planner_id, :date_time], unique: true
    end
  end

  def down
    drop_table :avaliable_frames
  end
end
