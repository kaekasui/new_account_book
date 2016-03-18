class AddFieldColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :breakdown_field, :boolean, default: true
    add_column :users, :place_field, :boolean, default: true
    add_column :users, :memo_field, :boolean, default: true
  end
end
