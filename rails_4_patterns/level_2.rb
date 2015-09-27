# 2.2 EXTRACT QUERY I
class Item < ActiveRecord::Base
  def self.featured
    where('rating > ? AND published_on > ?', 5, 2.days.ago)
  end
end

# 2.3 EXTRACT QUERY II
class ItemsController < ApplicationController
   def index
     @items = Item.featured
   end
 end

# 2.4 CLASS METHOD TO SCOPE 
class Item < ActiveRecord::Base
  scope :by_name, ->(name) { where(name: name) if name.present? }
  scope :recent, -> { where('created_on > ?', 2.days.ago) }
end

# 2.5 MERGING SCOPES I
class Item < ActiveRecord::Base
  has_many :reviews
  scope :recent, ->{
    where('published_on > ?', 2.days.ago)
    .joins(:reviews).merge(Review.approved)
  }
end

# 2.6 MERGING SCOPES II
Review.relevant.merge(Review.pending_approval)
