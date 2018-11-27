class GamesController < ApplicationController
  def show; end

  def move
    if canMove?(params[:from], params[:to])
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
