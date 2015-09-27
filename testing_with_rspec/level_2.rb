# Installing RSpec
$ gem install rspec

# Command Line
$ rspec --init

# Rails Configuration
$ rails g rspec:install

# Running specs from the command line
$ rspec --color --format documentation spec/models/zombie_spec.rb

# Predicate Matchers
describe Zombie do
  it 'includes a tweet' do
    tweet = Tweet.new
    zombie = Zombie.new(tweets: [tweet])
    zombie.tweets.should include(tweet)
  end
end

# Change Matcher
describe Zombie do
  it 'gains 3 IQ points by eating brains' do
    zombie = Zombie.new
    expect { zombie.eat_brains }.to change { zombie.iq }.by(3)
  end
end

# Have Matcher
describe Zombie do
  it 'increases the number of tweets' do
    zombie = Zombie.new(name: 'Ash')
    zombie.tweets.new(message: "Arrrgggggggghhhhh")
    zombie.should have(1).tweet
  end
end

# Raises an Error
describe Zombie do
  it 'raises a Zombie::NotSmartEnoughError if not able to make a decision' do
    zombie = Zombie.new
    expect { zombie.make_decision! }.to raise_error(Zombie::NotSmartEnoughError)
  end
end
