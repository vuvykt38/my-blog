class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    lastest_conversation = Conversation.conversations_of(current_user).limit(1).first
    redirect_to conversation_path(lastest_conversation)
  end

  def show
    @conversations = Conversation.conversations_of(current_user)
    @conversation = Conversation.find(params[:id])
  end
end
