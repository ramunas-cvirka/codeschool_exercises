# Factories
FactoryGirl.define do
  factory :zombie do
    name 'Sally'
    graveyard 'Valley Dim'
  end
end

# Complex Factories
FactoryGirl.define do
  factory :zombie do
    name 'Ash'
    graveyard 'Petrosville'

    factory :sally do
      name 'Sally'
      graveyard 'Valley Dim'
    end
    
    factory :moe do
      name 'Moe'
    end
  end
end

# Unique Attributes
FactoryGirl.define do
  factory :zombie do
    sequence(:name) { |i| "Ash#{i}" }
    sequence(:graveyard) { |i| "Petrosville Cemetary #{i}" }
  end
end

# Associations
FactoryGirl.define do
  factory :tweet do
    status 'Zzzz'
    association :zombie
  end
end

# Using Factories
class TweetTest < ActiveSupport::TestCase
  test "A tweet requires a status" do
    tweet = FactoryGirl.build(:tweet, status: nil)
    assert !tweet.valid?
  end
end

# Using Factories II
class TweetTest < ActionDispatch::IntegrationTest
  test "tweet page has zombie link" do 
    @tweet = Factory(:tweet)
    visit tweets_url
    click_on 'Need brain factory.'
    within 'h3' do
      has_content? @tweet.zombie.name
    end
  end
end
