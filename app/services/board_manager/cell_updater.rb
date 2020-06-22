module BoardManager
  class CellUpdater < ApplicationService
    PARAM_KEYS = %w(game_id row col)
    CELL_KEYS = %w(flagged revealed mine value)

    def initialize(params)
      game_id, row, col = params.values_at(*PARAM_KEYS)
      @game = Game.find(game_id)
      @row, @col = row.to_i, col.to_i
      @cell = @game.board[@row][@col]
      @cell.merge!(params.slice(*CELL_KEYS))
    end

    def call
      cell = Cell.new(@cell)
      @game.board[@row][@col] = @cell
      @game.start if cell.revealed && @game.cells_revealed.count == 1
      @game.over if cell.revealed && cell.mine
      @game.save
    end
  end
end
