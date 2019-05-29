require_relative "game"
require_relative "board"
require_relative "player"

class Main
  attr_reader :player, :board, :game

  def initialize(size=4)
    @board = Board.new(size)
    @player = Player.new(@board)
    @game = Game.new(@board, @player)
  end
end

main = Main.new

main.game.play