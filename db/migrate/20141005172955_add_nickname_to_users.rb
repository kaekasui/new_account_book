class AddNicknameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string, after: :name
  end
end
