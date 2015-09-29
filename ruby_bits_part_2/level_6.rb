# OPTIONAL PARAMETERS
LIBRARY = Library.new

def add_game(name, system = nil, year = nil, &block)
  game = Game.new(name)
  game.system(system) if system
  game.year(year) if year
  game.instance_eval(&block) if block_given?
  LIBRARY.add_game(game)
end

def with_game(name, &block)
  game = LIBRARY.find_by_name(name)
  game.instance_eval(&block)
end

# ARRAY PARAMETERS
LIBRARY = Library.new

def add_game(name, system = nil, year = nil, &block)
  game = Game.new(name)
  game.system(system) if system
  game.year(year) if year
  game.instance_eval(&block) if block_given?
  LIBRARY.add_game(game)
end

def with_game(*name, &block)
  name.each do |n|
    game = LIBRARY.find_by_name(n)
    game.instance_eval(&block)
  end
end

# TAGGING GAMES
class Game
  def initialize(name)
    @name = name
    @year = nil
    @system = nil
    @tags = []
  end

  def method_missing(m)
    @tags << m.to_s
  end
  
  def year(value)
    @year = value
  end

  def system(value)
    @system = value
  end

  def print_details
    puts "#{@name} - #{@year} (#{@system})"
  end

  def play
  end

  def capture_screenshot
  end
end

# FINDING GAMES BY TAG
LIBRARY = Library.new

def add_game(name, system = nil, year = nil, &block)
  game = Game.new(name)
  game.system(system) if system
  game.year(year) if year
  game.instance_eval(&block) if block_given?
  LIBRARY.add_game(game)
end

def with_game(*names, &block)
  names.each do |name|
    game = LIBRARY.find_by_name(name)
    game.instance_eval(&block)
  end
end

def with_games_tagged(tag, &block)
  games = LIBRARY.find_by_tag tag
  games.each { |g| g.instance_eval(&block) }
end

# ERROR HANDLING
class Game
  attr_reader :name, :tags

  def initialize(name)
    @name = name
    @year = nil
    @system = nil
    @tags = []
  end

  def year(value)
    @year = value
  end

  def system(value)
    @system = value
  end

  def print_details
    puts "#{@name} - #{@year} (#{@system})"
  end

  def play
    raise 'No emulator for SNES games.' if @system == 'SNES'
  end

  def capture_screenshot
  end

  def method_missing(method_name, *args)
    @tags << method_name.to_s
  end
end

# THE COMPLETED DSL
add_game("Civilization", "PC", 1991) { strategy turn_based }
add_game("Contra", "NES", 1987) { strategy turn_based }
add_game("The Legend of Zelda", "NES", 1986) { action rpg }
add_game("Mega Man X2", "SNES", 1995) { action }
add_game("Super Metroid", "SNES", 1994) { adventure platformer }
add_game("Sim City 2000", "PC", 1993) { strategy simulation }
add_game("Starcraft", "PC", 1998) { realtime strategy }
with_games_tagged('action') { print_details }
with_game('Contra', 'Sim City 2000') { capture_screenshot }
with_game('Starcraft') { play }
