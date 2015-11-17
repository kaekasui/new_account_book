class AddCategoryIdToRecords < ActiveRecord::Migration
  def change
    add_column :records, :category_id, :integer, after: :charge
  end
end
