class CreateMonthlyCounts < ActiveRecord::Migration
  def change
    create_table :monthly_counts do |t|
      t.integer :user_id
      t.integer :year
      t.integer :month
      t.integer :count

      t.timestamps
    end
  end
end
