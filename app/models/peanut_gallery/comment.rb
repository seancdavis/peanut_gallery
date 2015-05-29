module PeanutGallery
  class Comment < ActiveRecord::Base

    converts_markdown :markdown, :html

    belongs_to :item, :polymorphic => true
    belongs_to :author, :class_name => 'User'

    scope :newest_first, -> { order('created_at desc') }
    scope :oldest_first, -> { order('created_at asc') }

  end
end