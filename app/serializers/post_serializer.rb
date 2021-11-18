class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :image, :category
  has_one :user
end
