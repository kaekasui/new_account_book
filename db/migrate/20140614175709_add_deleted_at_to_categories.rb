class AddDeletedAtToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :deleted_at, :timestamp
  end
end
