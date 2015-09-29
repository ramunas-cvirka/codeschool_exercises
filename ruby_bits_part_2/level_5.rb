# THE GAME CLASS
class Game
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

# THE LIBRARY CLASS
class Library
  attr_reader :games
  def initialize
    @games = []
  end
  
  def add_game(game)
    @games.push game
  end
end

# ADDING GAMES
LIBRARY = Library.new

def add_game(name)
  game = Game.new(name)
  LIBRARY.add_game(game)
end

# INITIALIZING GAME DATA
##--- game.rb
class Game
  attr_reader :name

  def initialize(name)
    @name = name
    @year = nil
    @system = nil
  end

  def system(str)
    @system = str
  end
  
  def year(str)
    @year = str
  end
end
##--- game_dsl.rb
LIBRARY = Library.new

def add_game(name, &block)
  game = Game.new(name)
  game.instance_eval(&block)
  LIBRARY.add_game(game)
end

# LOOKING UP GAMES
LIBRARY = Library.new

def add_game(name, &block)
  game = Game.new(name)
  game.instance_eval(&block)
  LIBRARY.add_game(game)
end

def with_game(name, &block)
  game = LIBRARY.find_by_name(name)
  game.instance_eval(&block)
end

# OPERATING ON GAMES
class Game
  attr_reader :name

  def initialize(name)
    @name = name
    @year = nil
    @system = nil
  end

  def year(value)
    @year = value
  end

  def system(value)
    @system = value
  end

  # Add the print_details, play, and capture_screenshot methods here
  def print_details
    puts "#{@name} #{@year} #{@system}"
  end
  
  def play
  end
  
  def capture_screenshot
  end
end

# THE WORKING DSL
add_game "Civilization" do
  system "PC"
  year 1991
end
add_game "Contra" do
  system "NES"
  year 1987
end
with_game "Contra" do
  print_details
  play
  capture_screenshot
end
