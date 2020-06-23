module BoardManager
  class CellRevealer< ApplicationService
    def initialize(game, row, col)
      @game = game
      @row, @col = row.to_i, col.to_i
      @cell = Cell.new(@game.board[@row][@col])
    end

    def call
      @game.board[@row][@col][:revealed] = true
      NeighborsRevealer.call(@game, @row, @col) if @cell.value == 0
      @game.start if @game.cells_revealed.count == 1
      @game.over if @cell.mine
      @game.save
    end
  end
end
