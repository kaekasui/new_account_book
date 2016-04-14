class AddRecordsCountToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :records_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :categories, :records_count
  end
end
