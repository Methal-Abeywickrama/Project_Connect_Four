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
    # @board.push([@white, @blank, @black, @white, @blank, @black, @blank])
    @board.push(["1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 "])
    @columns = column_set
    p @columns
    p @board
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
    p column
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
    won = false
    @columns.each do |column|
      case column
      in [^shape, ^shape, ^shape, ^shape]
      end
    end
  end

  def add_piece(column_no=2, color='shite')
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
end


def play_game
  puts 'lets play a game of connect four'
  connect_four = ConnectFour.new
  connect_four.print_board

  won = false
  begin
    connect_four.add_piece(2, 'white')
    connect_four.add_piece(2, 'white')
    connect_four.add_piece(2, 'white')
    connect_four.add_piece(2, 'white')
    connect_four.add_piece(2, 'white')
    connect_four.add_piece(2, 'white')
    connect_four.print_board
  rescue ColumnFullError
    puts 'its ok'
  end

  # while !won
  #   'Player 1, select a column'
  # end

end

play_game