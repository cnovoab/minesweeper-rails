class Game < ApplicationRecord
  enum difficulty: [:beginner, :intermediate, :expert]
  enum state: [:unstarted, :playing, :won, :lost]
  before_create :set_board
  attribute :board, :json, array: true


  LEVEL_MAP = {
    beginner: { rows: 9, cols: 9, mines: 10 },
    intermediate: { rows: 16, cols: 16, mines: 40 },
    expert: { rows: 16, cols: 30, mines: 99 }
  }

  # def update_cell(params = {})
  #   BoardManager::CellFlagger(
  # end

  private
    def set_board
      self.rows = LEVEL_MAP[difficulty.to_sym][:rows]
      self.cols = LEVEL_MAP[difficulty.to_sym][:cols]
      self.mines = LEVEL_MAP[difficulty.to_sym][:mines]
      self.board = Array.new(self.rows, Array.new(self.cols, Cell.new))
    end
end
