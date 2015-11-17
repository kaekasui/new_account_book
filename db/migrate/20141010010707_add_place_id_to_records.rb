class AddPlaceIdToRecords < ActiveRecord::Migration
  def change
    add_column :records, :place_id, :integer, after: :breakdown_id
  end
end
