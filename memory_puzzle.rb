require_relative "board"
require_relative "player"
require_relative "card"

class MemoryPuzzle
  @@card_values = ("a".."z").to_a + ("A".."Z").to_a

  def initialize(board_size)
    @board = Board.new(board_size)
    @player = Player.new
    @prev_card = nil
    @selection = @@card_values.sample(board_size * board_size / 2)
    @pairs = (@selection + @selection).map { |card| Card.new(card) }
  end

  def play
    @board.shuffle(@pairs)
    @board.populate(@pairs)
    @board.render
    
    while !over?
      @board.render
      card = @player.get_card(@board)
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

new_game = MemoryPuzzle.new(4)
new_game.play