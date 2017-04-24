class RemoveSubIdToPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :sub_id
  end
end
