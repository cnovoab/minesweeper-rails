class Board
  attr_reader :rows, :cols, :mines, :cells

  LEVEL_MAP = {
    beginner: { rows: 9, cols: 9, mines: 10 },
    intermediate: { rows: 16, cols: 16, mines: 40 },
    expert: { rows: 16, cols: 30, mines: 99 }
  }

  def initialize(level)
    @rows = LEVEL_MAP[level.to_sym][:rows]
    @cols = LEVEL_MAP[level.to_sym][:cols]
    @mines = LEVEL_MAP[level.to_sym][:mines]
    @cells = Array.new(@rows, Array.new(@cols, Cell.new))
  end
end
