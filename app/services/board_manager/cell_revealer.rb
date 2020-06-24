module BoardManager
  class CellRevealer< ApplicationService
    def initialize(game, row, col)
      @game = game
      @row, @col = row.to_i, col.to_i
    end

    def call
      @game.board[@row][@col][:revealed] = true
      @game.start if @game.unstarted?
      @cell = Cell.new(@game.board[@row][@col])
      NeighborsRevealer.call(@game, @row, @col) if @cell.value == 0
      @game.over if @cell.mine
      @game.save
    end
  end
end
