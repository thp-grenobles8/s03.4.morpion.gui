class Cell
  attr_reader :status, :board

  def initialize
    @status = nil
    self
  end

  def link_to_board (board)
    @board = board
    self
  end

  def set(player)
    raise 'Case occupée !' if @status != nil
    @status = player.id
  end

  def render
    @status == nil ?
      " " :
      @board.game.players[@status-1].symbol
  end
end
