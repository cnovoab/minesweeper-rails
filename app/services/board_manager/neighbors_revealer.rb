module BoardManager
  class NeighborsRevealer < ApplicationService
    def initialize(game, row, col)
      @game = game
      @row, @col = row.to_i, col.to_i
    end

    def call
      neighbors = NeighborsRetriever.call(@game, @row, @col)
      empty_cells = []
      neighbors.each do |r, c|
        cell = Cell.new(@game.board[r][c])
        next if cell.revealed
        empty_cells << [r,c] if cell.value == 0
        @game.board[r][c][:revealed] = true
      end

      empty_cells.each do |r, c|
        NeighborsRevealer.call(@game, r, c)
      end
    end
  end
end
