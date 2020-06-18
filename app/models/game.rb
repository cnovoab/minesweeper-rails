class Game < ApplicationRecord
  enum difficulty: [:beginner, :intermediate, :expert]
  enum state: [:unstarted, :playing, :won, :lost]
  before_create :set_board

  def elapsed_time
    return nil if started_at.nil?
    (finished_at || Time.now) - started_at
  end

  private
    def set_board
      board = Board.new(difficulty)
      self.rows = board.rows
      self.cols = board.cols
      self.mines = board.mines
      self.board = board.cells
    end
end
