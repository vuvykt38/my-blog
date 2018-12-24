class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:category_id]
      @posts = Post.where(category_id: params[:category_id])
                   .order(updated_at: :desc)
                   .page(Integer(params[:page] || 1))
                   .per(10)
    else
      @posts = Post.page(Integer(params[:page] || 1))
                   .order(updated_at: :desc)
                   .per(10)
    end

    @posts = @posts.posts_for(current_user)
    @posts = @posts.search_by(params[:query])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
    if current_user == @post.author
      render 'edit'
    else
      redirect_to posts_path, flash: { error: 'You are not authorized to edit this post' }
    end
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    if current_user != @post.author
      redirect_to(posts_path, flash: { error: 'You are not authorized to update this post' }) && return
    end

    if @post.update(post_params)
      redirect_to @post, flash: { success: 'Post updated' }
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
    def post_params
      params.require(:post).permit(:title, :body, :category_id, :status, :image)
    end
end
