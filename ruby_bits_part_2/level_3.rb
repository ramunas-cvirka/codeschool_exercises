# A CLASS IS AN OBJECT
class Game
  puts "I am inside the #{self} class"
end

# REFACTORING CLASS METHODS
class Game
  def self.find_by_title(name)
  end
end

# CLASS_EVAL PART 1
Game.class_eval do
  def self.find_by_owner(name)
  end
end

# CLASS_EVAL PART 2
class LibraryManager
  def self.make_available(klass, user)
    klass.class_eval do
      define_method "lend_to_#{user}" do
      end
    end
  end
end

# INSTANCE_EVAL PART 1
contra_game = Game.new('Contra')
contra_game.instance_eval do
  self.owner = 'Alice'
end

# INSTANCE_EVAL PART 2
class Game
  def initialize(&block)
    self.instance_eval(&block) if block_given?
  end

  def owner(name=nil)
    if name
      @owner = name
    else
      @owner
    end
  end
end
