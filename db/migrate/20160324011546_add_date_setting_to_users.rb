class AddDateSettingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :date_setting, :integer
  end
end
