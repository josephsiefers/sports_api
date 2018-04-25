class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :update, :destroy]

  # GET /players
  def index

    @players = if params[:type] && Player.allowed_type?(params[:type])
      Player.where(type: "#{params[:type].titleize}Player")
    else
      Player.all
    end

    render json: @players
  end
end