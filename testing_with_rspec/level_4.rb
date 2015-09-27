# Clean up your code with before
describe Zombie do
  let(:zombie) { Zombie.new }
  subject { zombie }
  before { zombie.eat_brains }

  it { should_not be_dummy }
  it { should be_genius }
end

# Nested before filters
describe Zombie do
  let(:zombie) { Zombie.new }
  before { zombie.iq = 0 }
  subject { zombie }

  it { should be_dummy }

  context 'with a smart zombie' do
    before { zombie.iq = 3 }
    it { should_not be_dummy }
  end
end

# Nested before filters refactoring
describe Zombie do
  let(:zombie) { Zombie.new }
  subject { zombie }

  context 'with a dummy zombie' do
    before { zombie.iq = 0 }
  	it { should be_dummy }
  end

  context 'with a smart zombie' do
    before { zombie.iq = 3 }
    it { should_not be_dummy }
  end
end

# Shared Examples
shared_examples_for 'the brainless' do
  it { should be_dummy }
  it { should_not be_genius }  
end

describe Zombie do
  let(:zombie) { Zombie.new }
  subject { zombie }
  it_behaves_like 'the brainless'
end

describe Plant do
  let(:plant) { Plant.new }
  subject { plant }
  it_behaves_like 'the brainless'
end

# Metadata with filter
describe Zombie do
  let(:zombie) { Zombie.new }
  subject { zombie }

  context 'with a dummy zombie' do
    before { zombie.iq = 0 }
    it { should be_dummy }
  end

  context 'with a smart zombie', focus: true do
    before { zombie.iq = 3 }
    it { should_not be_dummy }
  end
end

# Running filtered specs
$ rspec --tag dumb spec/models/zombie_spec.rb

# Running filtered specs
$ rspec --tag ~dumb spec/models/zombie_spec.rb