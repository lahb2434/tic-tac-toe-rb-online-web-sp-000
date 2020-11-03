def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]
 
def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, player_character)
  board[index] = player_character
end

def position_taken?(board, index)
   !(board[index].nil? || board[index] == " ")
end

def play(board)
  playtime = 0
  while playtime < 9 
     turn(board)
     playtime +=1
  end
end
  
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board,index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      counter += 1
    end
  end
counter
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
 WIN_COMBINATIONS.each do |win_combination|
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]
 
  position_1 = board[win_index_1] 
  position_2 = board[win_index_2] 
  position_3 = board[win_index_3] 
 
  if position_1 == position_2 && position_2 == position_3 && position_taken?(board,win_index_1)
    return win_combination 
  end
  end
  false
end

def full?(board)
  board.none? {|i| i == " "}
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  elsif !(full?(board) && won?(board))
    return false
  else won?(board)
    return false
  end

end

def over?(board)
  draw?(board) || won?(board) || full?(board)
end

def winner(board)
  if won?(board) 
    return board[won?(board)[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board) == "X" || winner(board) == "O"
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cat's Game!"
  end
end
  


