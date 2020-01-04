class DropPlannerTable < ActiveRecord::Migration[5.2]
  def change
    remove_reference :reservations, :planner, foreign_key: true 
    remove_reference :available_frames, :planner, foreign_key: true
  
    drop_table :planners
  end
end
