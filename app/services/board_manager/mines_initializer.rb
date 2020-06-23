module BoardManager
  class MinesInitializer < ApplicationService
    def initialize(game)
      @game = game
    end

    def call
      mines = []
      while mines.count < @game.mines do
        row, col = rand(@game.rows), rand(@game.cols)
        cell = Cell.new(@game.board[row][col])
        next if cell.revealed || mines.include?([row, col])
        @game.board[row][col][:mine] = true
        mines << [row, col] 
      end
      @game.save
    end
  end
end
