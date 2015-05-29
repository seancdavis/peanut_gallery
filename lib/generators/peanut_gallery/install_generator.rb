require 'rake'
require 'rails/generators'

module PeanutGallery
  class InstallGenerator < Rails::Generators::Base
    desc "Add comment model migration to your project"

    source_root File.expand_path('../templates', __FILE__)

    def add_comment_model
      cols  = "item_id:integer item_type:string author_id:integer "
      cols += "markdown:text html:text"
      generate "model comment #{cols}"
    end

    def change_model_inheritance
      gsub_file 'app/models/comment.rb', /ActiveRecord\:\:Base/,
                'PeanutGallery::Comment'
    end

    def add_routes
      routes  = "\n  namespace :peanut_gallery do\n"
      routes += "    resources :comments, :only => [:create, :update, :destroy]\n"
      routes += "  end\n"
      inject_into_file 'config/routes.rb', routes,
                       :after => /Rails\.application\.routes\.draw\ do\n/
    end
  end
end
