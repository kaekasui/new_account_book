class RemoveExistenceFromCaptures < ActiveRecord::Migration[5.0]
  def change
    remove_column :captures, :category_existence
    remove_column :captures, :breakdown_existence
    remove_column :captures, :place_existence
  end
end
