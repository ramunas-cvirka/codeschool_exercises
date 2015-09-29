# PROCS
#-- library.rb
class Library
  attr_accessor :games

  def initialize(games)
    @games = games
  end

  def exec_game(name, action)
    game = games.detect { |game| game.name = name }
    action.call(game)
  end
end
#--- main.rb
library = Library.new(GAMES)
print_details = Proc.new do |game|
  puts "#{game.name} (#{game.system}) - #{game.year}"
end
library.exec_game("Contra", print_details)

# LAMBDAS
library = Library.new(GAMES)
print_details = lambda { |game| puts "#{game.name} (#{game.system}) - #{game.year}" }
library.exec_game('Contra', print_details)

# MULTIPLE LAMBDAS
class Library
  attr_accessor :games

  def initialize(games)
    @games = games
  end

  def exec_game(name, action, error)
    game = games.detect { |game| game.name == name }
  begin
    action.call(game)
  rescue
    error.call
  end
  end
end

# PROC TO BLOCK
library = Library.new(GAMES)
pr = Proc.new { |game| puts "#{game.name} (#{game.system}) - #{game.year}" }
library.each(&pr)

# CAPTURING BLOCKS
class Library
  attr_accessor :games

  def initialize(games)
    @games = games
  end

  def each(&game)
    games.each(&game)
  end
end

# PASSING BLOCKS
class Library
  attr_accessor :games

  def initialize(games)
    @games = games
  end

  def each(&block)
    games.each(&block)
  end
end

# SYMBOL#TO_PROC
class Library
  attr_accessor :games

  def initialize(games)
    @games = games
  end

  def names
    games.map(&:name)
  end
end

# OPTIONAL BLOCKS
class Library
  attr_accessor :games

  def initialize(games)
    @games = games
  end

  def list
    games.each do |game|
      if block_given?
        puts yield game
      else
        puts game.name
      end
    end
  end
end