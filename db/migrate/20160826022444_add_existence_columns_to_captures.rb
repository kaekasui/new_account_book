class AddExistenceColumnsToCaptures < ActiveRecord::Migration[5.0]
  def change
    add_column :captures, :category_existence, :boolean, default: false
    add_column :captures, :breakdown_existence, :boolean, default: false
    add_column :captures, :place_existence, :boolean, default: false
  end
end
