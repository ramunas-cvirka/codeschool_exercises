# STRUCT
Game = Struct.new(:name, :year, :system)

# EXTENDING STRUCT
Game = Struct.new(:name, :year, :system) do
  def to_s
    "#{name}, #{year}, #{system}"
  end
end

# ALIAS_METHOD
class Library
  attr_accessor :games
    
  def each(&block)
    games.each(&block)
  end
  
  alias_method :each_game, :each
end

# DEFINE_METHOD
class Game
  SYSTEMS = ['SNES', 'PS1', 'Genesis']

  attr_accessor :name, :year, :system
  
  SYSTEMS.each do |val|
    define_method "runs_on_#{val.downcase}?" do
      self.system = val
    end
  end
  
end

# SEND
library = Library.new(GAMES)
library.send(:list)
library.send(:emulate, "Contra")
game = library.send(:find, "Contra")

# PUBLIC_SEND
##--- library.rb
class Library
  attr_accessor :games

  def initialize(games)
    self.games = games
  end

  def list
    puts games.join("\n")
  end

  def emulate(name)
    game = find(name)
    puts "Starting emulator for #{game}..."
  end
  
  protected
  
  def find(name)
    games.detect { |game| game.name == name }
  end
end
##--- main.rb
library = Library.new(GAMES)
library.public_send(:list)
library.public_send(:emulate, "Contra")
game = library.public_send(:find, "Contra")

# LOOKING UP METHODS
library = Library.new(GAMES)
library.method(:list).call
library.method(:emulate).call("Contra")

# REFACTORING
class Library
  attr_accessor :games

  [:each, :map, :select].each do |m|
    define_method m do |&arg|
      games.send(m, &arg)
    end
  end
end