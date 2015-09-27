# First Model Test
class TweetTest < ActiveSupport::TestCase
  test "invalid without a status" do
    tweet = Tweet.new
    assert !tweet.valid?
  end
end

# Prepare the DB
$ rake db:te­st:prepare­ 

# Running Tests
rake

# Valid with Attributes
class TweetTest < ActiveSupport::TestCase
  test "valid with all attributes" do
    tweet = Tweet.new
    tweet.status = 'Moo'
    tweet.zombie = Zombie.new
    assert tweet.valid?
  end
end

# Fixtures
hello_world:
  zombie_id: 1
  status: 'hello world'

# Tests with Fixtures
class TweetTest < ActiveSupport::TestCase
  test "valid with all attributes" do
    tweet = tweets(:hello_world)
    assert tweet.valid?, "tweet isn't valid"
  end
end

# Model Methods
class TweetTest < ActiveSupport::TestCase
  test "can detect brains" do
    tweet = tweets(:hello_world)
    tweet.status = 'Hello brains'
    assert tweet.brains?
  end
end

# Testing Relationships
class TweetTest < ActiveSupport::TestCase
  test "contains a zombie" do
    assert_equal tweets(:hello_world).zombie, zombies(:ash)
  end
end
