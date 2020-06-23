module BoardManager
  class CellFlagger < ApplicationService
    def initialize(game, row, col, flag = true)
      @game = game
      @row, @col = row.to_i, col.to_i
      @cell = Cell.new(@game.board[@row][@col])
      @flag = flag
    end

    def call
      @game.board[@row][@col][:flagged] = @flag 
      @game.start if @game.unstarted?
      @game.save
    end
  end
end
