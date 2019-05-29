require_relative "board"

class Player
  def initialize(board)
    @board = board
  end

  def get_card
    card = nil

    while !card
      @board.render
      pos = get_pos
      card = @board[pos]
    end

    if card.faceup
      card = nil
      @board.render
    end

    card
  end

  def get_pos
    puts "Enter coordinates with no spaces"
    gets.chomp.split("").map { |str| str.to_i if "0123456789".include?(str) }
  end
end