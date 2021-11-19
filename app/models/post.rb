class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true
  validates :image, presence: true
  validates :category, presence: true
  validates :user_id, presence: true

  scope :title, -> (title) { where(title: title)}
  scope :category, -> (category) { where(category: category)}
end
