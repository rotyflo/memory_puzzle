class Player
  def get_card(board)
    card = nil

    while !card
      board.render
      pos = get_pos
      card = board[pos]

      if card
        card = nil if card.faceup
      end
    end

    card
  end

  def get_pos
    puts "Enter coordinates with no spaces"
    gets.chomp.split("").map { |char| char.to_i if "0123456789".include?(char) }
  end
end