module PeanutGallery
  module CommentsHelper

    def new_comment_form(obj, author = current_user)
      @comment = Comment.new if @comment.nil?
      simple_form_for @comment do |f|
        o  = f.input :markdown, :label => false,
                     :placeholder => 'Add a comment ...'
        o += f.input :item_id, :as => :hidden,
                     :input_html => { :value => obj.id }
        o += f.input :item_type, :as => :hidden,
                     :input_html => { :value => obj.class.to_s }
        o += f.input :author_id, :as => :hidden,
                     :input_html => { :value => author.id }
        o += f.input :redirect_route, :as => :hidden,
                     :input_html => { :value => request.path }
        o += f.submit "Add Comment"
      end
    end

  end
end
