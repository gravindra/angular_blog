class PostsController < ApplicationController

  def index
    @posts = current_user.posts
    # render json: @posts
  end

  def create
    post = current_user.posts.create!(post_params)
    render json: post
  end

  def update
    post = current_user.posts.find(params[:id])
    post.update_attributes(post_params)
    render nothing: true
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy
    render nothing: true
  end

  def show
    @post = current_user.posts.find(params[:id])
    # render json: @post
  end

  private
    def post_params
      params.require(:post).permit(:title)
    end
end
