class AddColumnsToCaptures < ActiveRecord::Migration[5.0]
  def change
    add_column :captures, :category_id, :integer
    add_column :captures, :breakdown_id, :integer
    add_column :captures, :place_id, :integer

    add_index :captures, :category_id
    add_index :captures, :breakdown_id
    add_index :captures, :place_id
  end
end
