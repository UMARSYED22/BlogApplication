class Tweet < ApplicationRecord
  extend FriendlyId
  friendly_id :content, use: :slugged
  belongs_to :user
  has_many :comments, as: :commentable
  validates :content, presence: true
end
