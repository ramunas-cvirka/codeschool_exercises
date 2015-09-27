# Implicit Subject
describe Zombie do
  it { should_not be_genius }
end

# Its Attribute
describe Zombie do
  its(:iq) { should == 0 }
end

# Refactoring into Contexts
describe Zombie do
  it { should_not be_genius }
  its(:iq) { should == 0 }
  context "with high iq" do
    subject { Zombie.new(iq: 3) }
    it { should be_genius }
    its(:brains_eaten_count) { should == 1 }
  end
end

# Subject with Lets
describe Zombie do
  let(:tweet) { Tweet.new }
  let(:zombie) { Zombie.new(tweets: [tweet]) }
  subject { zombie }
  its(:tweets) { should include(tweet) }
  its(:latest_tweet) { should == tweet } 
end

# Method as a subject
describe Zombie do
  context "with high iq" do
    let!(:zombie) { Zombie.create(iq: 3, name: 'Anna') }
    subject { zombie }

    it "should be returned with genius" do
      Zombie.genius.should include(zombie)
    end

    it "should have a genius count of 1" do     
      Zombie.genius.count.should == 1
    end
  end
end
