#helper methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, char)
  char = current_player(board)
  board[index] = char
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
  if (index.to_i >= 0) && (position_taken?(board,index.to_i) == false)
    if (index.to_i <= 9) && (position_taken?(board,index.to_i) == false)
      return true
    else
      return false
    end
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index)
    move(board, index, char = current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |index|
    if index == "X" || index == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else turn_count(board) % 2 == 1
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    if position_taken?(board, win_combo[0]) && position_taken?(board, win_combo[1]) && position_taken?(board,win_combo[1])
      if (board[win_combo[0]] == board[win_combo[1]]) && (board[win_combo[1]] == board[win_combo[2]])
        return win_combo
      end
    end
  end
  return nil
end

def full?(board)
  if (board.detect{|i| i ==" "} || board.detect{|i| i ==""}) == nil
    return true
  else
    return false
  end
end

def draw?(board)
  if full?(board)
    if won?(board)
      return false
    else
      return true
    end
  else
    return false
  end
end

def over?(board)
  if (draw?(board) || won?(board)) || full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  won = won?(board)
  if won != nil
    return board[won[0]]
  else return nil
  end
end

#constant = win combinations
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

#play methods

def play(board)
  until over?(board) == true || turn_count(board) == 9 || draw?(board) == true || won?(board) == true
    char = "X"
    turn(board)
    over?(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
