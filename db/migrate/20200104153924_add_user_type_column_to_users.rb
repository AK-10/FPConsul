# frozen_string_literal: true

class AddUserTypeColumnToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :user_type, :integer, default: 0, null: false
    add_index :users, :user_type
  end

  def down
    remove_column :users, :user_type
    remove_index :users, :user_type
  end
end
