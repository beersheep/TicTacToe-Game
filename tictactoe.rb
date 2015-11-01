require "pry"

WINNING_CONDITION = [ [1,2,3],[4,5,6],[7,8,9],
                      [1,4,7],[2,5,8],[3,6,9],
                      [1,5,9],[3,5,7]]

def initialize_board
	b = {}
	(1..9).each {|position| b[position] = position}
	b
end

def draw_board(b)
  system "clear"
  puts "    |    |    "
  puts " #{b[1]}  | #{b[2]}  | #{b[3]}  "
  puts "——————————————"
  puts "    |    |    "
  puts " #{b[4]}  | #{b[5]}  | #{b[6]}  "
  puts "——————————————"
  puts "    |    |    "
  puts " #{b[7]}  | #{b[8]}  | #{b[9]}  "
end

def empty_square(board)
  board.select {|position, mark| mark != "O" && mark != "X"}.keys
end


def player_pick_square(board)
  puts "Please select a square(1-9): "
  position = gets.chomp.to_i

  if !empty_square(board).include?(position)
    loop do
      puts "The square was taken! Please select another square."
      position = gets.chomp.to_i
      break if square_empty?(board).include?(position)
    end
  end

  board[position] = "X"

end

def computer_pick_square(board)
  position = empty_square(board).sample
  board[position] = "O"
end


def check_winner(board)
  WINNING_CONDITION.each do |line|
    return "Player" if board.values_at(*line).count("X") == 3
    return "Computer" if board.values_at(*line).count("O") == 3
  end
  nil  
end

board = initialize_board
draw_board(board)

begin 
	player_pick_square(board)
	draw_board(board)
	computer_pick_square(board)
	draw_board(board) 
  winner = check_winner(board)
end until winner || empty_square(board).empty?

if winner == "Player"
  puts "You won!"
elsif winner == "Computer"
  puts "Computer won!"
else 
  puts "It's a tie!"
end
  

