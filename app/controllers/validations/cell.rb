module Validate
  class Cell
    include ActiveModel::Validations
    attr_accessor :revealed, :flagged

    validates_inclusion_of :revealed, in: [true, false]
    validates_inclusion_of :flagged, in: [true, false]
    
    def initialize(params={})
      @revealed = params[:revealed]
      @flagged = params[:flagged]
      ActionController::Parameters.new(params).permit(:revealed, :flagged)
    end
  end
end
