class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to :back
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to :back
    end
  end
  private
  def comment_params
    params.require(:comment).permit(:content,:event_id, :user_id)
  end

end
