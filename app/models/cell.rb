class Cell
  include ActiveModel::Type
  attr_accessor :revealed, :flagged, :mine, :value

  def initialize(params = {})
    @revealed = Boolean.new.cast(params[:revealed])
    @flagged = Boolean.new.cast(params[:flagged])
    @mine = Boolean.new.cast(params[:mine])
    @value = params[:value]
  end
end
