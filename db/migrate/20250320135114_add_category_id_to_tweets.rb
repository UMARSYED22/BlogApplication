class AddCategoryIdToTweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :category_id, :bigint
  end
end
