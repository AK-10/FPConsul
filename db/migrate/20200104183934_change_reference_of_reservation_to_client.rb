# frozen_string_literal: true

class ChangeReferenceOfReservationToClient < ActiveRecord::Migration[5.2]
  def up
    add_reference :reservations, :client, foreign_key: { to_table: :users }, null: false
    remove_reference :reservations, :user, foreign_key: true
    add_reference :reservations, :planner, foreign_key: { to_table: :users }, null: false
    add_index :reservations, [:planner_id, :scheduled_time], unique: true
  end

  def down
    remove_reference :reservations, :client, foreign_key: true
    add_reference :reservations, :user, foreign_key: true
    remove_reference :reservations, :planner, foreign_key: true
    remove_index :reservations, [:planner_id, :scheduled_time]
  end
end
