class Category < ApplicationRecord
  has_and_belongs_to_many :blogs
  has_many :tweets
  # validates :name, presence: true
end
