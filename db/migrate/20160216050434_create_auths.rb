class CreateAuths < ActiveRecord::Migration
  def change
    create_table :auths do |t|
      t.references :user
      t.string :provider
      t.string :screen_name
      t.string :name

      t.timestamps null: false
    end
  end
end
