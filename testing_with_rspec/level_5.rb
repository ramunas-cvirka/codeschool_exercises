# Stubbing
describe ZombieMailer do
  context '#tweet' do
    let(:zombie) { stub(email: 'anything@example.org') }
    let(:tweet) { stub(message: 'Arrrrgggghhhh', zombie: zombie) }

    subject { ZombieMailer.tweet(zombie, tweet) }
    its(:from) { should include('admin@codeschool.com') }
    its(:to) { should include(zombie.email) }
    its(:subject) { should == tweet.message }
  end
end

# Named Stubs
describe ZombieMailer do
  context '#tweet' do
    let(:zombie) { stub(:zombie, email: 'anything@example.org') }
    let(:tweet) { stub(:tweet, message: 'Arrrrgggghhhh') }

    subject { ZombieMailer.tweet(zombie, tweet) }
    its(:from) { should include('admin@codeschool.com') }
    its(:to) { should include(zombie.email) }
    its(:subject) { should == tweet.message }
  end
end

# Mocking
describe Tweet do
  context 'after create' do
    let(:zombie) { Zombie.create(email: 'anything@example.org') }
    let(:tweet) { zombie.tweets.new(message: 'Arrrrgggghhhh') }

    it 'calls "email_tweeter" on the tweet' do
      tweet.should_receive(:email_tweeter)
      tweet.save
    end
  end
end

# Mocking with a return value
describe Tweet do
  context 'after create' do
    let(:zombie) { Zombie.create(email: 'anything@example.org') }
    let(:tweet) { zombie.tweets.new(message: 'Arrrrgggghhhh') }
    let(:mail) { stub(deliver: true) }

    it 'calls "tweet" on the ZombieMailer' do
      ZombieMailer.should_receive(:tweet).and_return(mail)
      tweet.save
    end
  end
end

# Checking Method Params
describe Tweet do
  context 'after create' do
    let(:zombie) { Zombie.create(email: 'anything@example.org') }
    let(:tweet) { zombie.tweets.new(message: 'Arrrrgggghhhh') }
    let(:mail) { stub(deliver: true) }

    it 'calls "tweet" on the ZombieMailer' do
      ZombieMailer.should_receive(:tweet).with(zombie, tweet).and_return(mail)
      tweet.save
    end
  end
end

# Verifying Delivery
describe Tweet do
  context 'after create' do
    let(:zombie) { Zombie.create(email: 'anything@example.org') }
    let(:tweet) { zombie.tweets.new(message: 'Arrrrgggghhhh') }
    let(:mail) { stub(:mail, deliver: true) }

    it 'calls "tweet" on the ZombieMailer' do
      ZombieMailer.should_receive(:tweet).with(zombie, tweet).and_return(mail)
      tweet.save
    end

    it 'calls "deliver" on the mail object' do
      ZombieMailer.stub(tweet: mail)
      mail.should_receive(:deliver)
      tweet.save
    end
  end
end

# Message Counts
describe Tweet do
  context 'after create' do
    let(:zombie) { Zombie.create(email: 'anything@example.org') }
    let(:tweet) { zombie.tweets.new(message: 'Arrrrgggghhhh') }
    let(:mail) { stub(:mail, deliver: true) }

    it 'calls "tweet" on the ZombieMailer as many times as there are zombies' do
      Zombie.stub(all: [stub, stub, stub])
      ZombieMailer.should_receive(:tweet).exactly(Zombie.all.count).times.and_return(mail)
      tweet.save
    end
  end
end
