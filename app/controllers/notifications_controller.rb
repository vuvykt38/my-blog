class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.page(Integer(params[:page] || 1)).per(10)
  end

  def show
    notification = current_user.notifications.find_by(id: params[:id])
    if notification&.update(read: true)
      redirect_to notification.link
    else
      redirect_to notifications_path, flash: { error: "unable to see notification" }
    end
  end
end
