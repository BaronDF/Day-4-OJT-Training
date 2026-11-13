class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def make_move
    puts "#{@name}, Enter your move (1-9): "
    gets.chomp.to_i
  end
end

class HumanPlayer < Player
  def introduce
    puts "Player #{@name} use #{@symbol}"
  end
end

class TicTacToe
  def initialize
    @board = Array.new(9, " ")
    @players = [
      HumanPlayer.new("Player 1", "X"),
      HumanPlayer.new("Player 2", "O")
    ]
    @current_player = 0
  end

  def display_board
    3.times do |row|
      puts "#{@board[row * 3]} | #{@board[row * 3 + 1]} | #{@board[row * 3 + 2]}"
      puts "---+---+---" unless row == 2
    end
    puts
end

def valid_move?(position)
  position.between?(1, 9) &&
  @board[position - 1] == " "
end

def check_winner
  winning_combination = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ]

  winning_combination.any? do |combo|
    a, b, c = combo
    @board[a] != " " &&
      @board[a] == @board[b] &&
      @board[b] == @board[c]
  end
end

def play
  loop do

    @board = Array.new(9, " ")
    @current_player = 0

  puts "\nWelcome to Tic Tac Toe"

  loop do
    display_board

    player = @players[@current_player]
    position = player.make_move

    unless valid_move?(position)
      puts "Invalid move! Try again"
      next
    end

    @board [position - 1] = player.symbol

    if check_winner
      display_board
      puts "#{player.name} wins!"
      break
    elsif !@board.include?(" ")
      display_board
      puts "It's a draw"
      break
    end

    @current_player = 1 - @current_player
  end
  puts "\nDo you want to keep playing? (y/n)"
  answer =  gets.chomp.downcase

  break unless answer == "y"
end
  puts "Thanks for playing!"
end
end

game = TicTacToe.new
game.play
