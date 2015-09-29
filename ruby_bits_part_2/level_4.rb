# METHOD_MISSING PART 1
class Library
  def method_missing(m, *a, &b)
    puts m
  end
end

# METHOD_MISSING PART 2
class Library
  def method_missing(name, *args)
    puts name, *args
  end
end

# DELEGATING PART 1
class Library
  def initialize(console)
    @manager = console
  end

  def method_missing(name, *args)
    @manager.send(name, *args)
  end
end

# DELEGATING PART 2
class Library
  def initialize(console)
    @manager = console
  end

  def method_missing(name, *args)
    if name =~ /atari/
      @manager.send(name, *args)
    else
      super
    end
  end
end

# DELEGATING PART 3
require 'delegate'
class Library < SimpleDelegator
  def initialize(console)
    @manager = console
    super(@manager)
  end
end

# DEFINE_METHOD REVISITED
class Library
  SYSTEMS = ['arcade', 'atari', 'pc']

  attr_accessor :games

  def method_missing(name, *args)
    system = name.to_s
    if SYSTEMS.include?(system)
      self.class.class_eval do
        define_method name do
          find_by_system(system)
        end  
      end
      send(name)
    else
      super
    end
  end

  private

  def find_by_system(system)
    games.select { |game| game.system == system }
  end
end

# RESPOND_TO?
class Library
  SYSTEMS = ['arcade', 'atari', 'pc']

  attr_accessor :games

  def method_missing(name, *args)
    system = name.to_s
    if SYSTEMS.include?(system)
      self.class.class_eval do
        define_method(system) do
          find_by_system(system)
        end
      end
      send(system)
    else
      super
    end
  end

  def respond_to?(m)
    SYSTEMS.include?(m.to_s) || super
  end
  private

  def find_by_system(system)
    games.select { |game| game.system == system }
  end
end
