class CellController < ApplicationController
  before_action :set_cell, only: [:show, :update]

  def show
    render json: @game.board[@row][@col]
  end

  def update
    if BoardManager::CellUpdater.call(@game, @row, @col, @data)
      render json: @game.reload.board[@row][@col]
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  private
    def set_cell
      @game = Game.find(params[:game_id])
      @row = params[:row].to_i
      @col = params[:col].to_i
      @data = params.slice(:revealed, :flagged)
    end

    def cell_params
      params.permit(:revealed, :flagged, :game_id, :row, :col)
    end
end
