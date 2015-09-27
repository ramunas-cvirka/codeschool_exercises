# Scopes I
class Tweet < ActiveRecord::Base
  scope :recent, order("created_at desc").limit(4)
end

# Scopes II
class Tweet < ActiveRecord::Base
  scope :recent, order('created_at desc').limit(4) 
  scope :graveyard, where(show_location: true, location: 'graveyard')
end

# Using Scopes
class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
    @graveyard_tweets = Tweet.recent.graveyard
  end
end

# Before Save
class Tweet < ActiveRecord::Base
  before_save :check_location
  
  def check_location
    self.show_location = true if self.location?
  end
end

# Callback Logging
class Tweet < ActiveRecord::Base
  after_update :log_update
  after_destroy :log_destroy

  def log_update
    logger.info "Tweet #{id} updated"
  end

  def log_destroy
    logger.info "Tweet #{id} deleted"
  end
end

# Has One
class Tweet < ActiveRecord::Base
  has_one :location
end

class Location < ActiveRecord::Base
  belongs_to :tweet
end

# Foreign Key
class Tweet < ActiveRecord::Base
  has_one :location, foreign_key: :tweeter_id, dependent: :destroy
end

class Location < ActiveRecord::Base
  belongs_to :tweet, foreign_key: :tweeter_id, dependent: :destroy
end

# Includes
class TweetsController < ApplicationController 
  def index
    @tweets = Tweet.includes(:location).recent
  end
end

# Relationship Migration
class AddTweetCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
    end
    create_table :categorizations do |t|
      t.integer :tweet_id
      t.integer :category_id
    end    
  end 
end

# Has Many Through
class Tweet < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, through: :categorizations
end

class Categorization < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :category
end

class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :tweets, through: :categorizations
end
