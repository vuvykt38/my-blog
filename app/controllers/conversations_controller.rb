class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.conversations_of(current_user)
  end
end
