class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, after: :token
  end
end
