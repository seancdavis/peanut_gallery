class << ActiveRecord::Base

  def has_comments
    has_many :comments, :as => :item
  end

end
