class Game < ApplicationRecord
  enum difficulty: [:beginner, :intermediate, :expert]
  before_create :set_board
  before_update :check_win
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
      BoardManager::MinesInitializer.call(game.id)
    end

    after_transition to: :lost do |game|
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
        revealed << [i, j] if cell.revealed && !cell.mine
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
      state == :playing &&
        cells_revealed.count == (rows * cols) - mines
    end
end
