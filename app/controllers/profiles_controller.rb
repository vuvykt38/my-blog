class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def message
    user = User.find(params[:id])
    conversation = Conversation.between(user.id, current_user.id).first_or_create
    UserConversation.find_or_create_by(user: user, conversation: conversation)
    UserConversation.find_or_create_by(user: current_user, conversation: conversation)
    redirect_to conversation_path(conversation)
  end

  def edit;end

  def update
    if current_user.update(profile_params)
      redirect_to profile_path(current_user), flash: { success: 'Profile updated' }
    else
      render 'edit'
    end
  end

  def following
    @user = User.find(params[:id])
    render 'show_following'
  end

  def followers
    @user = User.find(params[:id])
    render 'show_follower'
  end

  private
    def profile_params
      params.permit(:full_name, :avatar, :bio)
    end

end
