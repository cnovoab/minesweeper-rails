module BoardManager
  class MinesRevealer < ApplicationService
    def initialize(game)
      @game = game
    end

    def call
      puts "cellsmined: #{@game.cells_mined}"
      @game.cells_mined.each do |row, col|
        puts "row: #{row} | col: #{col}"
        @game.board[row][col][:revealed] = true
      end
      @game.save
    end
  end
end
