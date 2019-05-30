class Board
  attr_reader :size, :grid

  def initialize(size)
    @size = size
    @grid = Array.new(size) { Array.new(size) }
  end

  def shuffle(cards)
    cards.sample(cards.length)
  end

  def populate(cards)
    i = 0

    (0...@size).each do |x|
      (0...@size).each do |y|
        @grid[x][y] = cards[i]
        
        i += 1
      end
    end
  end
  
  def render
    system("clear")
    puts "  " + (0...@size).to_a.join(" ")
    @grid.each_with_index do |line, i|
      print i.to_s + " "
      line.each { |card| print card.display + " " }
      puts
    end
  end
  
  def won?
    cards.all? { |card| card.faceup }
  end

  def [](pos)
    x, y = pos

    if valid_pos?(x, y) then @grid[y][x] else nil end
  end

  def valid_pos?(x, y)
    [x, y].all?(Numeric) && (0...@size).include?(x) && (0...@size).include?(y)
  end
end