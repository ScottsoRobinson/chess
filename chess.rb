#!/usr/bin/env ruby

require_relative 'lib/board'
require_relative 'lib/piece'
require_relative 'lib/sliding_piece'
require_relative 'lib/stepping_piece'
require_relative 'lib/bishop'
require_relative 'lib/king'
require_relative 'lib/knight'
require_relative 'lib/pawn'
require_relative 'lib/rook'
require_relative 'lib/queen'
require_relative 'lib/computer_player'
require_relative 'lib/human_player'
require_relative 'lib/game'
require 'byebug'
require 'colorize'
DELTAS_ALL = {
  :row_col => [
    [1,0],
    [-1,0],
    [0,1],
    [0,-1]
  ],
  :diag    => [
    [1,1],
    [-1,1],
    [1,-1],
    [-1,-1]
  ],
  :knights => [
    [1,2],
    [1,-2],
    [2,1],
    [2,-1],
    [-1,2],
    [-1,-2],
    [-2,1],
    [-2,-1]
  ]
}

class Array

  def on_board?

    self.all? {|el| el.between?(0,7)}

  end

end

if __FILE__ == $PROGRAM_NAME

  puts "Would you like to play against a computer? Y or N?"
  response = gets.chomp.upcase
  if response == "Y"
    player2 = :computer
  else
    player2 = :human
  end

  game = Game.new(player2)
  game.play


end
