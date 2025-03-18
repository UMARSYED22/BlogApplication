class Blog < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  has_many :comments, as: :commentable
  validates :title, presence: true
  validates :body, presence: true
  enum status: { draft: 0, published: 1 }
  has_and_belongs_to_many :categories
end
