class Game < ApplicationRecord
  enum difficulty: [:beginner, :intermediate, :expert]
  enum state: [:unstarted, :playing, :won, :lost]
  before_create :set_board
  attribute :board, :json, array: true

  state_machine :state, initial: :unstarted do

    event :start do
      transition unstarted: :playing
    end

    event :win do
      transition playing: :won
    end

    event :loss do
      transition playing: :lost
    end

    after_transition to: :playing, do: :start
  end

  LEVEL_MAP = {
    beginner: { rows: 9, cols: 9, mines: 10 },
    intermediate: { rows: 16, cols: 16, mines: 40 },
    expert: { rows: 16, cols: 30, mines: 99 }
  }

  def start
    started_at = Time.now
  end

  private
    def set_board
      self.rows = LEVEL_MAP[difficulty.to_sym][:rows]
      self.cols = LEVEL_MAP[difficulty.to_sym][:cols]
      self.mines = LEVEL_MAP[difficulty.to_sym][:mines]
      self.board = Array.new(self.rows, Array.new(self.cols, Cell.new))
    end
end
