class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def create
    # Game.create_game_for(current_user, games_params)
  end

  def index
    @games = Game.visible
                 .page(Integer(params[:page] || 1))
                 .per(10)
  end

  def join
    game = Game.find(params[:id])
    if game.join!(current_user)
      redirect_to game_path(game), flash: { success: 'joined' }
    else
      redirect_to games_path, flash: { error: game.errors.full_messages.join('. ') }
    end
  end

  def show
    game = Game.find(params[:id])
    respond_to do |format|
      format.html { render }
      format.json { render json: { board: game.board } }
    end
  end

  def move
    game = Game.find(params[:id])
    if canMove?(params[:from], params[:to])
      game.move(params[:from], params[:to])
      render json: { current_board: [], message: 'success' }
    else
      render json: { current_board: [], message: 'fail' }, status: :unprocessable_entity
    end
  end


  private

  def canMove?(from, to)
    from != to
  end
end
