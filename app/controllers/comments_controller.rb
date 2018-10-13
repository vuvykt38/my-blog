class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = post.comments.build(comment_params)
    comment.user = current_user
    if comment.save
      redirect_to post_path(post), flash: { success: 'Comment added' }
    else
      redirect_to post_path(post), flash: { error: comment.errors.full_messages.join('. ') }
    end
  end

  def destroy
    post = current_user.posts.find_by(id: params[:post_id])
    comment = post&.comments&.find_by(id: params[:id])
    if comment&.destroy
      redirect_to post_path(post), flash: { success: 'Comment deleted' }
    else
      redirect_to post_path(params[:post_id]), flash: { error: 'An error occurred' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
