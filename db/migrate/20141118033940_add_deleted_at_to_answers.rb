class AddDeletedAtToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :deleted_at, :timestamp, after: :content
  end
end
