class BoardController < ApplicationController
  before_action :set_game, only: :show

  def show
    render json: @game.board
  end

  private
    def set_game
      @game = Game.find(params[:game_id])
    end
end
