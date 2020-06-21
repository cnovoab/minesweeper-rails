module BoardManager
  class CellUpdater < ApplicationService
    PARAM_KEYS = %w(game_id row col)
    CELL_KEYS = %w(flagged revealed mine value)
    def initialize(params)
      game_id, row, col = params.values_at(*PARAM_KEYS)
      @game = Game.find(game_id)
      @row = row.to_i
      @col = col.to_i
      @cell = @game.board[@row][@col]
      @cell_value = params.values_at(*CELL_KEYS)
    end

    def call
      @game.board[@row][@col] = @cell.merge(@cell_value)
      @game.save
    end
  end
end
