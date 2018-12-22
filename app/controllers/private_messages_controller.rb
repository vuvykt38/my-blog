class PrivateMessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @private_messages = current_user.private_messages.page(Integer(params[:page] || 1)).per(10)
    @private_messages&.update(read: true)
  end
end
