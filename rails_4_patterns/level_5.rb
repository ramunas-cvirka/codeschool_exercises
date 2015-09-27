# 5.2 Basic Serializer
class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :description
end

# 5.3 Remove Root Node
class ReviewArraySerializer < ActiveModel::ArraySerializer
  self.root = false
end

# 5.4 Custom Property
class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :description, :approve_url
  
  def approve_url
    approve_review_url(object)
  end
end

