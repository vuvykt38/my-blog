class PrivateMessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    conversation = Conversation.find(params[:conversation_id])
    private_message = conversation.private_messages.new(private_message_params)
    private_message.sender = current_user
    if private_message.save
      redirect_to conversation_path(conversation)
    else
      redirect_to conversation_path(conversation)
    end
  end

  private

  def private_message_params
    params.require(:private_message).permit(:body, :read)
  end
end
