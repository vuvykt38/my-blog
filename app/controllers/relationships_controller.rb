class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    relationship = Relationship.create(follower: current_user, followed_id: params[:user_id])
    if relationship.persisted?
      redirect_to request.referer || posts_path, flash: { success: 'Followed' }
    else
      redirect_to request.referer || posts_path, flash: { error: relationship.errors.full_messages.join('. ') }
    end
  end

  def unfollow
    relationship = current_user.following_relationships.find_by(followed_id: params[:user_id])

    if relationship.destroy
      redirect_to request.referer || posts_path, flash: { success: 'Unfollowed' }
    else
      redirect_to request.referer || posts_path, flash: { error: 'errors' }
    end
  end
end
