class AddSentAtToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :sent_at, :timestamp
  end
end
