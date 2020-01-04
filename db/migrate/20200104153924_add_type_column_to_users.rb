class AddTypeColumnToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :type, :integer, default: 0, null: false
    add_index :users, :type
  end

  def down
    remove_column :users, :type
    remove_index :users, :type
  end
end
