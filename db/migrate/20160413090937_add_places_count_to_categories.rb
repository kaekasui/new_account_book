class AddPlacesCountToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :places_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :categories, :places_count
  end
end
