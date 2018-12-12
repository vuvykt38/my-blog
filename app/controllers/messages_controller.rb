class MessagesController < ApplicationController
  def index
    messages = Message.all
  end

  def create
    game = Game.find(params[:game_id])
    message = game.messages.build(message_params)
    message.user = current_user
    if message.save
      redirect_to game_path(game), flash: { success: 'message added' }
    else
      redirect_to game_path(game), flash: { error: message.errors.full_messages.join('. ') }
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
