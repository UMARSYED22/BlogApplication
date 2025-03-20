class Comment < ApplicationRecord
  extend FriendlyId
  friendly_id :content, use: :slugged
  validates :slug, uniqueness: true
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  validates :content, presence: true
end
