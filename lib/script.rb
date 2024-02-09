# frozen_string_literal: true

# rubocop: convention:Style/StringLiterals

require_relative 'errors'

class ConnectFour
  attr_accessor :board, :columns
  WHITE = "\u26AA".freeze
  BLACK = "\u26AB".freeze
  BLANK = "\u274D ".freeze

  def initialize
    @board = Array.new(6) { Array.new(7, BLANK) }
    @board.push(["1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 "])
    @columns = column_set
  end

  def change_square(a, b)
    p @board
    p @board[a]
    p @board[a][b]
    @board[a][b] = WHITE
  end

  def define_column(column_no)
    column = []
    @board.each do |row| 
      break if row[0] == "1 "

      column.push(row[column_no])
    end
    column
  end

  def column_set
    columns = []
    for i in 0..6 do 
      columns[i] = define_column(i)
    end
    columns
  end

  def check_win(shape)
    shape = shape == 'white' ? WHITE : BLACK
    won = false
    @diagonals = get_diagonals
    @columns.each do |column|
      case column
      in [*, ^shape, ^shape, ^shape, ^shape, *]
        won = true
        return true
      else 
        won = false
      end
    end
    @board.each do |row|
      case row
      in [*, ^shape, ^shape, ^shape, ^shape, *]
        won = true
        return true
      else 
        won = false
      end
    end
    @diagonals.each do |diagonal|
      case diagonal
        in [*, ^shape, ^shape, ^shape, ^shape, *]
        won = true
        return true
      else 
        won = false
      end
    end
    won
  end

  def get_diagonals
    [[@board[3][0], @board[2][1], @board[1][2], @board[0][3]],
     [@board[4][0], @board[3][1], @board[2][2], @board[1][3], @board[0][4]],
     [@board[5][0], @board[4][1], @board[3][2], @board[2][3], @board[1][4], @board[0][5]],
     [@board[5][1], @board[4][2], @board[3][3], @board[2][4], @board[1][5], @board[0][6]],
     [@board[5][2], @board[4][3], @board[3][4], @board[2][5], @board[1][6]],
     [@board[5][3], @board[4][4], @board[3][5], @board[4][6]],
     [@board[2][0], @board[3][1], @board[4][2], @board[5][3]],
     [@board[1][0], @board[2][1], @board[3][2], @board[4][3], @board[5][4]],
     [@board[0][0], @board[1][1], @board[2][2], @board[3][3], @board[4][4], @board[5][5]],
     [@board[0][1], @board[1][2], @board[2][3], @board[3][4], @board[4][5], @board[5][6]],
     [@board[0][2], @board[1][3], @board[2][4], @board[3][5], @board[4][6]],
     [@board[0][3], @board[1][4], @board[2][5], @board[3][6]]]
  end

  def add_piece(column_no=2, color='white')
    column = @columns[column_no - 1]
    color == 'white' ? color = WHITE : color = BLACK
    raise ColumnFullError.new('sd') unless column.any?(BLANK)

    column.each_with_index do |space, index|

      
      if column[index + 1] != BLANK && space == BLANK
        @board[index][column_no - 1] = color
        @columns = column_set
      end
   
    end
    
  end

  def print_board
    @board.each do |row|
      print "| "
      row.each { |space| print "#{space} " }
      print "|\n"
    end
  end

  def get_valid_input
    valid = false
    until valid
      valid = true
      input = gets.chomp.to_i 
      if input.zero? || @columns[input - 1].none?(BLANK)
        valid = false
        puts 'Invalid input, try again'
      end
    end
    input 
  end
end


def play_game
  puts 'lets play a game of connect four'
  connect_four = ConnectFour.new
  connect_four.print_board

  won = false
  while !won
    puts 'Player 1, select a column'
    input = connect_four.get_valid_input
    connect_four.add_piece(input, 'white')
    connect_four.print_board
    won = connect_four.check_win('white')
    if won
      puts 'Winner is player 1'
      break
    end

    puts 'Player 2, select a column'
    input = connect_four.get_valid_input
    connect_four.add_piece(input, 'black')
    connect_four.print_board
    won = connect_four.check_win('black')
    if won
      puts 'Winner is player 2'
      break
    end
  end
 


end

play_game