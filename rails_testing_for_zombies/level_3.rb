# Setup Method
class TweetTest < ActiveSupport::TestCase
  def  setup
    @tweet = tweets(:hello_world)
  end
  
  test "invalid without a status" do
    @tweet.status = nil
    assert !@tweet.valid?, "Status is not being Validated"
  end

  test "valid with all attributes" do
    assert @tweet.valid?, "tweet isn't valid"
  end
end

# Custom Assert
class TweetTest < ActiveSupport::TestCase

  def setup
    @tweet = tweets(:hello_world)
  end

  # Don't change this, use it to refactor the tests below.
  def assert_attribute_is_validated(model, attribute)
    # This line sets the specified attribute to nil 
    model.assign_attributes(attribute => nil)
    assert !model.valid?, "#{attribute.to_s} is not being validated"
  end

  test "invalid without a status" do  
    assert_attribute_is_validated @tweet, :status
  end

  test "invalid without a zombie" do
    assert_attribute_is_validated @tweet, :zombie
  end
end

# Test Helper
##--- tweet_test.rb
class TweetTest < ActiveSupport::TestCase
  def setup
    @tweet = tweets(:hello_world)
  end

  #you don't need to touch this
  test "invalid without a status" do
    assert_attribute_is_validated @tweet, :status
  end

  #you don't need to touch this
  test "invalid without a zombie" do
    assert_attribute_is_validated @tweet, :zombie
  end
end
##--- test_helper.rb
class ActiveSupport::TestCase
  def assert_attribute_is_validated(model, attribute)
    model.assign_attributes(attribute => nil)
    assert !model.valid?, "#{attribute.to_s} is not being validated"
  end
end

# Introducing Shoulda
class TweetTest < ActiveSupport::TestCase
  should validate_presence_of :status
  should validate_presence_of :zombie
end

# Shoulda I
class TweetTest < ActiveSupport::TestCase
  should validate_numericality_of :id
  should validate_uniqueness_of :id
end

# Shoulda II
class TweetTest < ActiveSupport::TestCase
  should ensure_length_of(:status).is_at_least(3).is_at_most(140)
end
