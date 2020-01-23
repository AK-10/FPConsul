# frozen_string_literal: true

class AddAvailableFrameIdColumnAndRemovePlannerIdColumnAndScheduledTime < ActiveRecord::Migration[5.2]
  def up
    add_reference :reservations, :available_frame, null: false, foreign_key: true, index: { unique: true }
    remove_index :reservations, [:planner_id, :scheduled_time]
    remove_reference :reservations, :planner, foreign_key: { to_table: :users }, index: true
    remove_column :reservations, :scheduled_time, null: false
  end

  def down
    add_reference :reservations, :planner, foreign_key: { to_table: :users }
    remove_reference :reservations, :available_frame, foreign_key: true, index: true

    add_column :reservations, :scheduled_time, :datetime, null: false, comment: "予約枠の日時(開始時間)"
    add_index :reservations, [:planner_id, :scheduled_time], unique: true
  end
end
