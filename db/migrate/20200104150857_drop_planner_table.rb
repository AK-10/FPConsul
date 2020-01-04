class DropPlannerTable < ActiveRecord::Migration[5.2]
  def up
    remove_index :reservations, [:planner_id, :scheduled_time]
    remove_reference :reservations, :planner, foreign_key: true
    remove_index :available_frames, [:planner_id, :scheduled_time]
    remove_reference :available_frames, :planner, foreign_key: true
  
    drop_table :planners
  end

  def down
    create_table :planners do |t|
      t.string :name, null: false, limit: 50
      t.string :email, null: false, limit: 100
      t.string :password_digest, null: false
      t.timestamp

      t.index :email, unique: true
    end

    add_reference :reservations, :planner, foreign_key: true
    add_index :reservations, [:planner_id, :scheduled_time]
    add_reference :available_frames, :planner, foreign_key: true
    add_index :avaialble_frames, [:planner_id, :scheduled_time]
  end
end
