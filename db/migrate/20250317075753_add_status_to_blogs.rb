class AddStatusToBlogs < ActiveRecord::Migration[7.2]
  def change
    add_column :blogs, :status, :integer
  end
end
