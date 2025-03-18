class RemoveCategoryIdFromBlogs < ActiveRecord::Migration[7.2]
  def change
    remove_column :blogs, :category_id, :bigint
  end
end
