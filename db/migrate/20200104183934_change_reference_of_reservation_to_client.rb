class ChangeReferenceOfReservationToClient < ActiveRecord::Migration[5.2]
  def change
    add_reference :reservations, :client, foreign_key: { to_table: :users }
    remove_reference :reservations, :user, foreign_key: true
    add_reference :reservations, :planner, foreign_key: { to_table: :users }
  end
end
