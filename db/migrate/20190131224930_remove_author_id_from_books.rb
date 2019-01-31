class RemoveAuthorIdFromBooks < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :author_id, :integer
  end
end
