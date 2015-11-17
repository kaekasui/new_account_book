class AddCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :code, :string, after: :token
  end
end
