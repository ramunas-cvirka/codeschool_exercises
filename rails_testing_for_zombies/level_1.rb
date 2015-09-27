# Unit Test
require 'test/unit'

class ConditionalTest < Test::Unit::TestCase
  def test_one_greater_than_zero
    assert 1 > 0
  end
end

# Error Messages
class ConditionalTest < Test::Unit::TestCase
  def test_one_greater_than_zero
    assert 0 > 1, 'One is not greater than zero'
  end
end

# Test Driven Development
class MultipleTest < Test::Unit::TestCase
  def test_multiple_of
    assert_equal Multiple.multiple_of?(10, 5), true
  end
end

# Write the Method
module Multiple
  def self.multiple_of?(multiple, num)
    multiple % num == 0
  end
end

# assert_not_nil
class ZombifierTest < Test::Unit::TestCase
  def test_zombify_returns_something
    z = Zombifier.new('make me a zombie')
    assert_not_nil z.zombify
  end
end

# assert_match
class ZombifierTest < Test::Unit::TestCase
  def test_zombify_brains
    z = Zombifier.new('I love your arms')
    assert_match /BRAINS/, z.zombify
  end
end

# assert_equal
class ZombifierTest < Test::Unit::TestCase
  def test_zombify_upcase
    assert_equal 'HELLO WORLD BRAINS', Zombifier.new("Hello world").zombify
  end
end

# assert_raise
class ZombifierTest < Test::Unit::TestCase
  def test_brains_in_zombify_raises_error
    z = Zombifier.new('BRAINS')
    assert_raise(RuntimeError) { z.zombify }
  end
end

# assert_kind_of
class ZombifierTest < Test::Unit::TestCase
  def test_zombify_returns_a_string
    z = Zombifier.new('I like knees')
    assert_kind_of String, z.zombify
  end
end
