require_relative "board"
require_relative "player"
require_relative "card"
require_relative "computer"

class MemoryPuzzle
  @@card_values = ("a".."z").to_a + ("A".."Z").to_a

  def initialize(board_size)
    @board = Board.new(board_size)
    @human = Player.new
    @computer = Computer.new
    @current_player = @human
    @other_player = @computer
    @cards_flipped = 0
    @prev_card = nil
    @selection = @@card_values.sample(board_size * board_size / 2)
    @pairs = (@selection + @selection).map { |card| Card.new(card) }
  end

  def play
    @pairs = @board.shuffle(@pairs)
    @board.populate(@pairs)
    @board.render
    
    while !over?
      @board.render
      card, pos = @current_player.get_card_and_pos(@board)
      card.reveal
      @board.render
      make_guess(card)

      @computer.memorize_card(card.face_value, pos)

      @cards_flipped += 1
      if @cards_flipped == 2
        switch_players
        @cards_flipped = 0
      end
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
      elsif card.face_value == @prev_card.face_value
        @computer.receive_match(card.face_value)
      end

      @prev_card = nil
    end
  end

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

  def over?
    @board.grid.all? do |line|
      line.all? { |card| card.faceup }
    end
  end
end

new_game = MemoryPuzzle.new(4)
new_game.play