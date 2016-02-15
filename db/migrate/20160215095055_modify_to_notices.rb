class ModifyToNotices < ActiveRecord::Migration
  def change
    remove_column :notices, :post_at
    add_column :notices, :post_at, :date
  end
end
