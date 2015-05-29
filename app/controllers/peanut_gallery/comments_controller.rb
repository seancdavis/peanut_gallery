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

  private

    def comment_params
      params
        .require(:peanut_gallery_comment)
        .permit(:markdown, :item_id, :item_type, :author_id)
    end

end
