class RemoveUserIdFromTaggedRecords < ActiveRecord::Migration[5.0]
  def change
    remove_column :tagged_records, :user_id
  end
end
