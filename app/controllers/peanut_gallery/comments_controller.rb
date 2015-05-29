class PeanutGallery::CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to params[:peanut_gallery_comment][:redirect_route],
                  :notice => 'Comment created!'
    else
      redirect_to params[:peanut_gallery_comment][:redirect_route],
                  :notice => 'Comment could not be saved.'
    end
  end

  def update
    @comment = Comment.find_by_id(params[:id])
    if @comment.nil?
      raise "Could not find comment."
    else
      if @comment.save
        redirect_to request.referrer, :notice => 'Comment saved!'
      else
        redirect_to request.referrer, :notice => 'Comment could not be saved.'
      end
    end
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    if @comment.nil?
      raise "Could not find comment."
    else
      @comment.destroy
      redirect_to request.referrer, :notice => 'Comment deleted!'
    end
  end

  private

    def comment_params
      params
        .require(:peanut_gallery_comment)
        .permit(:markdown, :item_id, :item_type, :author_id)
    end

end
