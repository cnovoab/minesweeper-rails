module BoardManager
  class CellUpdater < ApplicationService
    def initialize(game, row, col, data)
      @game = game
      @row, @col = row.to_i, col.to_i
      @cell = Cell.new(@game.board[@row][@col])
      @data = data 
    end

    def call
      if @data[:revealed] == true
        return CellRevealer.call(@game, @row, @col)
      elsif @data.key? :flagged
        return CellFlagger.call(@game, @row, @col, @data[:flagged])
      end
    end
  end
end
