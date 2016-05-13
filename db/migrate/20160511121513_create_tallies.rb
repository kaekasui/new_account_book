class CreateTallies < ActiveRecord::Migration
  def change
    create_table :tallies do |t|
      t.integer :user_id
      t.integer :year
      t.integer :month
      t.text :list

      t.timestamps null: false
    end
  end
end
