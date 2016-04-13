class AddBreakdownsCountToCategories < ActiveRecord::Migration

  def self.up
    add_column :categories, :breakdowns_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :categories, :breakdowns_count
  end
end
