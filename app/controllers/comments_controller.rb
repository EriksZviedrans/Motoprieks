class CommentsController < ApplicationController
before_filter :login_required_commenter
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    redirect_to :back
  end
end
