class ChangeReferenceOfReservationToClient < ActiveRecord::Migration[5.2]
  def up
    add_reference :reservations, :client, foreign_key: { to_table: :users }, null: false
    add_index :reservations, [:planner_id, :scheduled_time], :unique: true
    remove_reference :reservations, :user, foreign_key: true
    add_reference :reservations, :planner, foreign_key: { to_table: :users }, null: false
  end

  def down
    remove_ference :reservation, :client, foreign_key: true
    add_reference :reservations, :user, foreign_key: true
    remove_reference :reservations, :planner, foreign_key: true
  end
end
