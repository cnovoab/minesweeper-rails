class Cell
  include ActiveModel::Type
  attr_accessor :revealed, :flagged, :mine, :value

  def initialize(params = {})
    params.symbolize_keys!
    @revealed = Boolean.new.cast(params[:revealed]) || false
    @flagged = Boolean.new.cast(params[:flagged]) || false
    @mine = Boolean.new.cast(params[:mine]) || false
    @value = params[:value]
  end
end
