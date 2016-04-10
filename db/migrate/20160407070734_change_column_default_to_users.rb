class ChangeColumnDefaultToUsers < ActiveRecord::Migration
  def change
    change_column_default :users, :tag_field, true
  end
end
