# Stubbing
class TweetTest < ActiveSupport::TestCase
  def setup
    @tweet = tweets(:hello_world)
  end

  test "show_author_summary should set status to zombie summary" do 
    @tweet.zombie.stubs(:zombie_summary)
    @tweet.show_author_summary
    assert_equal @tweet.zombie.zombie_summary, @tweet.status, 'tweet status does not contain zombie summary'
  end
end

# Mocking
class TweetTest < ActiveSupport::TestCase
  def setup
    @tweet = tweets(:hello_world)
  end

  test "show_author_summary should call zombie_summary" do
    @tweet.zombie.expects(:zombie_summary)
    @tweet.show_author_summary
  end
end

# Stub + Assert
class TweetTest < ActiveSupport::TestCase
  def setup
    @tweet = tweets(:hello_world)
  end

  test "status_image calls the ZwitPic get_status_image api" do 
    ZwitPic.expects(:get_status_image).with(@tweet.id)
    @tweet.status_image
  end
end

# Stubs & Mocking
class TweetTest < ActiveSupport::TestCase
  def setup
    @tweet = tweets(:hello_world)
  end

  test "status_image calls the ZwitPic get_status_image api" do 
    ZwitPic.expects(:get_status_image).with(@tweet.id).returns(['a','b'])
    @tweet.status_image
  end
end

# Returning Proper Results
class TweetTest < ActiveSupport::TestCase
  def setup
    @tweet = tweets(:hello_world)
  end

  test "status_image returns a properly formated HTML image element with alt and src" do
    ZwitPic.stubs(:get_status_image).returns({url:'rose.png', name:'rose'})
    assert_equal "<img src='rose.png' alt='rose' />", @tweet.status_image
  end
end

# Object Stub
class TweetTest < ActiveSupport::TestCase
  def setup
    @tweet = tweets(:hello_world)
  end

  test "status_image returns a properly formated HTML image element with alt and src" do
    res = stub(name: 'Yummy brain I ate last night', url: 'http://zwitpic.com/2.jpg')
    ZwitPic.stubs(:get_status_image).with(@tweet.id).returns(res)
    assert_equal "<img src='http://zwitpic.com/2.jpg' alt='Yummy brain I ate last night' />", @tweet.status_image
  end
end
