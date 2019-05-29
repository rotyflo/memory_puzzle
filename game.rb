require_relative "board"
require_relative "player"

class Game
  def initialize(board, player)
    @board = board
    @player = player
    @prev_card = nil
  end

  def play
    @board.shuffle
    @board.populate
    @board.render
    
    while !over?
      @board.render
      card = @player.get_card
      card.reveal
      @board.render
      make_guess(card)
    end

    puts "You won!"
  end

  def make_guess(card)
    if @prev_card == nil
      @prev_card = card
    else
      if card.face_value != @prev_card.face_value
        sleep(1)
        card.hide
        @prev_card.hide
      end

      @prev_card = nil
    end
  end

  def over?
    @board.grid.all? do |line|
      line.all? { |card| card.faceup }
    end
  end
end