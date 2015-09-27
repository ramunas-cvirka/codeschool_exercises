# Rails Integration Test
class TweetDisplaysStatusTest < ActionDispatch::IntegrationTest
  def setup
    @tweet = tweets(:hello_world)
  end

  test "Tweet page responds successfully" do
    get tweet_url(@tweet)
    assert_response :success
  end

  test "Tweet displays status in heading" do 
    get tweet_url(@tweet)
    assert_select "h1", @tweet.status
  end
end

# Rails Integration Test - POST
class CreatingATweetTest < ActionDispatch::IntegrationTest
  def setup
    @zombie = zombies(:ash)
    @tweet_attributes = {tweet: {zombie_id: @zombie.id, status: 'Test tweet'}}
  end

  test "Responds with a redirect to the tweet page" do
    post tweets_url, @tweet_attributes
    assert_redirected_to tweet_url(Tweet.last)
  end
end

# Capybara Integration Test
class TweetDisplaysStatusTest < ActionDispatch::IntegrationTest
  def setup
    @tweet = tweets(:hello_world)
  end

  test "Tweet displays status in heading" do
    visit tweet_url(@tweet)
    has_selector? 'h1', text: @tweet.status
  end
end

# Capybara Integration Test II
class CreatingATweetTest < ActionDispatch::IntegrationTest
  test 'should create a new tweet' do
    visit new_tweet_url
    fill_in 'tweet_status', with: 'missed alarm clock'
    select 'bob', from: 'tweet_zombie_id'
    click_button 'Create Tweet'
    assert_equal tweet_path(Tweet.last), current_path
  end
end

# Capybara Integration Test III
class CreatingATweetTest < ActionDispatch::IntegrationTest
  test 'should go to new tweet page' do
    visit root_path
    click_on 'New Tweet'
    assert_equal new_tweet_path, current_path
  end
end

# Helper Methods
##--- creating_a_tweet_test.rb
class CreatingATweetTest < ActionDispatch::IntegrationTest
  test 'should create a new tweet' do
    create_tweet_for 'Ash', 'I love the way your brain feels'
    assert_equal tweet_path(Tweet.last), current_path
  end
end
##--- test_helper.rb
class ActiveSupport::TestCase
  def create_tweet_for(zombie, status)
  	visit new_tweet_url
    fill_in 'Status', with: status
    select zombie, from: 'Zombie'
    click_button 'Create Tweet'
  end
end
