class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @item = @comment.item
    @user_of_item = @comment.item.user
    if @comment.save
      respond_to do |format|
        format.json
      end
    else
      render item_path(comment.item)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy!

  end

  private
  def comment_params
    params.require(:comment).permit(:text, :item_id).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
