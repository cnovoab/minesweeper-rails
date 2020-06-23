module BoardManager
  class ValuesInitializer < ApplicationService
    def initialize(game)
      @game = game
    end

    def call
      @game.board.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          cell = Cell.new(cell)
          next if cell.mine
          neighbors = NeighborsRetriever.call(@game, i, j) 
          mines_around = neighbors & @game.cells_mined
          @game.board[i][j][:value] = mines_around.count
        end
      end
      @game.save
    end
  end
end
