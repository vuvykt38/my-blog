class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.page(Integer(params[:page] || 1)).per(10)
  end
end
