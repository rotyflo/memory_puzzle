require_relative "board"

class Game
  def initialize(size=4)
    @size = size
    @board = Board.new(size)
    @prev_card = nil
    @matched = []
  end

  def play
    @board.shuffle
    @board.populate
    @board.render
    
    while !over?
      @board.render
      card = nil
      while !card
        begin
          card = @board[get_pos]
        rescue
          puts "try 01"
        end

        if card.faceup
          card = nil
          @board.render
        end
      end
      card.reveal
      @board.render
      make_guess(card)
    end

    puts "You won!"
  end

  def get_pos
    puts "Enter coordinates with no spaces"
    gets.chomp.split("").map { |str| str.to_i }
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