require 'faker'

# Clear existing data
User.destroy_all
Category.destroy_all
Blog.destroy_all
Tweet.destroy_all
Comment.destroy_all

# Define a default password for all users
default_password = 'password123'

# Create Users
5.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: default_password, # Set a consistent password for all users
    password_confirmation: default_password,
    slug: Faker::Internet.unique.slug,
    roles: ['admin', 'user'].sample
  )
end

# Create Categories
10.times do
  Category.create!(
    name: Faker::Book.genre
  )
end

# Create Blogs
users = User.all
categories = Category.all

50.times do
  # Generate a body with at least 300 words
  body = Faker::Lorem.paragraphs(number: 20).join(' ') # Adjust number to reach 300 words

  blog = Blog.create!(
    title: Faker::Book.title,
    body: body,
    user: users.sample,
    slug: Faker::Internet.unique.slug,
    status: [0, 1].sample
  )

  # Assign categories to blogs
  blog.categories << categories.sample(rand(1..3))
end

# Create Tweets
50.times do
  Tweet.create!(
    content: Faker::Lorem.sentence,
    user: users.sample,
    category: categories.sample,
    slug: Faker::Internet.unique.slug
  )
end

# Create Comments
blogs = Blog.all
tweets = Tweet.all

100.times do
  Comment.create!(
    content: Faker::Lorem.sentence,
    commentable: (blogs + tweets).sample,
    user: users.sample,
    slug: Faker::Internet.unique.slug
  )
end

puts "Database seeded successfully!"