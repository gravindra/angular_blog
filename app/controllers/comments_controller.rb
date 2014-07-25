class CommentsController < ApplicationController

	def index
    render json: post.comments
  end

  def create
    @comment = post.comments.create!(safe_params)
    # render json: comment, status: 201
  end

  def update
    comment.update_attributes(safe_params)
    render nothing: true, status: 204
  end

  def destroy
    comment.destroy
    render nothing: true, status: 204
  end

  private
  def post
    @post ||= Post.find(params[:post_id])
  end

  def comment
    @comment ||= post.comments.find(params[:id])
  end

  def safe_params
    params.require(:comment).permit(:body)
  end

end
