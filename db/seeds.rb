# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
## Seed Blogs
blogs = Blog.create([
  { title: 'First Blog Post', body: 'This is the content of the first blog post.' },
  { title: 'Second Blog Post', body: 'This is the content of the second blog post.' },
  { title: 'Third Blog Post', body: 'This is the content of the third blog post.' }
])

# Seed Tweets
tweets = Tweet.create([
  { content: 'This is my first tweet!' },
  { content: 'Hello world, this is my second tweet.' },
  { content: 'Tweeting is fun!' }
])

# Seed Comments
comments = Comment.create([
  { content: 'Great blog post!', commentable: blogs.first },
  { content: 'I totally agree with this.', commentable: blogs.second },
  { content: 'Nice tweet!', commentable: tweets.first },
  { content: 'Interesting perspective.', commentable: tweets.second }
])

categories = [
  { name: 'Sports' },
  { name: 'Health' },
  { name: 'Technology' },
  { name: 'Education' },
  { name: 'Entertainment' }
]
