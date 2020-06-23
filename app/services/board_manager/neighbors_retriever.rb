module BoardManager
  class NeighborsRetriever < ApplicationService
    def initialize(game, row, col)
      @game = game
      @row, @col = row.to_i, col.to_i
    end

    def call
      neighbors = []
      (@row - 1..@row + 1).each do |r|
        (@col - 1..@col + 1).each do |c|
          neighbors << [r, c] if valid_tuple(r, c)
        end
      end
      neighbors
    end

    private
      def valid_tuple(row, col)
        row >= 0 && row < @game.rows.to_i &&
          col >= 0 && col < @game.cols.to_i &&
          !(row == @row && col == @col)
      end
  end
end
