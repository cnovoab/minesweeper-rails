class Game < ApplicationRecord
  enum difficulty: [:beginner, :intermediate, :expert]
  before_create :set_board
  after_update :check_win
  attribute :board, :json, array: true

  state_machine :state, initial: :unstarted do
    event :start do |game|
      transition :unstarted => :playing
    end

    event :win do
      transition playing: :won
    end

    event :over do
      transition playing: :lost
    end

    after_transition to: :playing do |game|
      game.update(started_at: Time.now)
      BoardManager::MinesInitializer.call(game)
      BoardManager::ValuesInitializer.call(game)
    end

    after_transition to: [:lost, :won] do |game|
      game.update(finished_at: Time.now)
    end
  end

  LEVEL_MAP = {
    beginner: { rows: 9, cols: 9, mines: 10 },
    intermediate: { rows: 16, cols: 16, mines: 40 },
    expert: { rows: 16, cols: 30, mines: 99 }
  }

  def elapsed_time
    ((finished_at || Time.now) - started_at).to_i
  end

  def cells_revealed
    revealed = []
    board.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        cell = Cell.new(cell)
        revealed << [i, j] if cell.revealed
      end
    end
    revealed
  end

  def cells_mined
    mines = []
    board.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        cell = Cell.new(cell)
        mines << [i, j] if cell.mine
      end
    end
    mines
  end

  def cells_flagged
    flags = []
    board.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        cell = Cell.new(cell)
        flags << [i, j] if cell.flagged
      end
    end
    flags
  end

  def cells_to_reveal
    (rows * cols) - mines
  end

  private
    def set_board
      self.rows = LEVEL_MAP[difficulty.to_sym][:rows]
      self.cols = LEVEL_MAP[difficulty.to_sym][:cols]
      self.mines = LEVEL_MAP[difficulty.to_sym][:mines]
      self.board = Array.new(self.rows, Array.new(self.cols, Cell.new))
    end

    def check_win
      self.win if win_conditions
    end

    def win_conditions
      playing? && cells_revealed.count == cells_to_reveal
    end
end
