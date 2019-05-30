class Computer
  def initialize
    @matched_cards = []
    @known_cards = Hash.new([])
    @flipped_cards = 0
  end

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

    @flipped_cards += 1
    @flipped_cards = 0 if @flipped_cards == 2
    sleep(1)

    [card, pos]
  end

  def get_pos
    puts "Computer thinking..."

    @known_cards.each do |card, positions|
      if positions.length == 2
        if !@matched_cards.include?(card)
          if @flipped_cards == 0
            return positions[0]
          elsif @flipped_cards == 1
            receive_match(card)
            return positions[1]
          end
        end
      end
    end
    
    [(0..3).to_a.sample, (0..3).to_a.sample]
  end

  def memorize_card(card, pos)
    @known_cards[card] += [pos] if @known_cards[card].none?(pos)
  end

  def receive_match(card)
    @matched_cards += [card]
  end
end