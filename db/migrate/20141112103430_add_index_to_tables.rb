class AddIndexToTables < ActiveRecord::Migration
  def change
    add_index :breakdowns, :category_id
    add_index :breakdowns, :user_id
    add_index :cancels, :user_id
    add_index :categories, :user_id
    add_index :feedbacks, :user_id
    add_index :monthly_counts, :user_id
    add_index :places, :user_id
    add_index :records, :category_id
    add_index :records, :breakdown_id
    add_index :records, :place_id
    add_index :records, :user_id
    add_index :tagged_records, :record_id
    add_index :tagged_records, :tag_id
    add_index :tagged_records, :user_id
    add_index :tags, :user_id
  end
end
