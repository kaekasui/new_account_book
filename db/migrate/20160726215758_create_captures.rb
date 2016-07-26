class CreateCaptures < ActiveRecord::Migration[5.0]
  def change
    create_table :captures do |t|
      t.date :published_at
      t.integer :charge
      t.string :category_name
      t.string :breakdown_name
      t.string :place_name
      t.text :memo
      t.references :user, index: true
      t.text :tags

      t.timestamps
    end
  end
end
