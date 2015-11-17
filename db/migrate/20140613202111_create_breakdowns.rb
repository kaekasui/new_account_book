class CreateBreakdowns < ActiveRecord::Migration
  def change
    create_table :breakdowns do |t|
      t.string :name
      t.integer :category_id
      t.integer :user_id
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
