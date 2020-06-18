class Cell
  attr_reader :revealed, :flagged, :mine, :value

  def initialize(params = {})
    @revealed = params[:revealed] || false
    @flagged = params[:flagged] || false
    @mine = params[:mine] || false
    @value = params[:value]
  end
end
