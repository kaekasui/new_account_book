class AddCommentToCaptures < ActiveRecord::Migration[5.0]
  def change
    add_column :captures, :comment, :text
  end
end
