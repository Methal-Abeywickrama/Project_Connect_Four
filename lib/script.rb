# frozen_string_literal: true

# rubocop: convention:Style/StringLiterals

class ConnectFour
  attr_accessor :blank, :white, :black

  def initialize
    @white = "\u26AA"
    @black = "\u26AB"
    @blank = "\u274D "
    @board = Array.new(6, Array.new(7, @blank))
    # @board.push([@white, @blank, @black, @white, @blank, @black, @blank])
    @board.push(["1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 "])
    @columns = column_set
    p @columns
    p @board
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

  def add_piece(column_no, color)
    column = @columns[column_no - 1]
    
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

  while !won
    'Player 1, select a column'
  end

end

play_game