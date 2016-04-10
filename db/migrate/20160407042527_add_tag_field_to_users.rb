class AddTagFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tag_field, :boolean
  end
end
