# 6.2 Associations
class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :description, :approve_url
  has_many :comments
  def approve_url
    approve_review_url(object)
  end
end

# 6.3 Embeding Ids
class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :description, :approve_url

  has_many :comments, embed: :id

  def approve_url
    approve_review_url(object)
  end
end

# 6.4 Side Loading Associations
class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name
  
  has_many :reviews
  embed :ids, include: true
end

# 6.5 Custom Methods
class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :reviews
  embed :ids, include: true
  
  def reviews
    object.reviews.approved
  end
  
end

# 6.6 Attributes
class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name

  def attributes
    data = super
    data[:price] = object.price if current_user
    data
  end
end

# 6.7 Custom Scope
class ApplicationController < ActionController::Base
  serialization_scope :current_session
end