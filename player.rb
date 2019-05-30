class Player
  def get_card_and_pos(board)
    card = nil

    while !card
      board.render
      pos = get_pos
      card = board[pos]

      if card
        card = nil if card.faceup
      end
    end

    @last_card

    [card, pos]
  end

  def get_pos
    puts "Enter coordinates"
    gets.chomp.split("").map { |char| char.to_i if "0123456789".include?(char) }
  end
end