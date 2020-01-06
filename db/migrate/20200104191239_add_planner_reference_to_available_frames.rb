# frozen_string_literal: true

class AddPlannerReferenceToAvailableFrames < ActiveRecord::Migration[5.2]
  def up
    add_reference :available_frames, :planner, foreign_key: { to_table: :users }, null: false
    add_index :available_frames, [:planner_id, :scheduled_time], unique: true
  end

  def down
    remove_reference :available_frames, :planner, foreign_key: true
    remove_index :available_frames, [:planner_id, :scheduled_time]
  end
end
