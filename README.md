PeanutGallery
==========

PeanutGallery adds a simple commenting feature to your Ruby on Rails
application.

Installation
----------

### Add Gem To Project

Add this line to your application's Gemfile:

```ruby
gem 'peanut_gallery'
```

And then execute:

```text
$ bundle
```

Or install it yourself as:

```text
$ gem install peanut_gallery
```

### Add the Comment Model

Next, you'll want to add a `Comment` model to your application. You can do this
by running the install generator:

```text
$ bundle exec rails g peanut_gallery:install
```

This will add a migration, so you'll want to migrate your database.

```text
$ bundle exec rake db:migrate
```

> The install generator adds a `Comment` model to your application. You'll
> notice the model file has no content, but still works. That's because it is
> inheriting from the `PeanutGallery::Comment` model. This is so we can hide
> the abstracted (repeated) logic. But, you're welcome to override any default
> logic in your project's `Comment` model.
>
> *Note: PeanutGallery never accesses the base model by default. It will always
> look for the `Comment` model in your project.*

Usage
----------

There are three items to be concerned with to get PeanutGallery working
properly:

1. Routes
2. Associations
3. Forms

### Routes

Running the install generator should add the following to your
`config/routes.rb` file:

```ruby
namespace :peanut_gallery do
  resources :comments, :only => [:create, :update, :destroy]
end
```

If something went wrong and you don't see this, go ahead and add it manually.

### Associations

For any model that you want to have comments, all you have to do is all
`has_comments` to the model. For example, if a `Post` model has comments, your
model might look like this:

```ruby
class Post < ActiveRecord::Base
  has_comments
end
```

This means you can call `comments` on any single object within this model.

### Forms

There is a helper made available to you for rendering a form:

```erb
<%= new_comment_form(object, author) %>
```

Here the `object` is the item to which you want to attach the comment. The
`author` is the object of the user who is adding the comment.

> *Note: PeanutGallery assumes (but does not require) you're using a `User`
> model, and that the logged in user is `current_user`. Therefore, you can
> leave off the `author` parameter if you have your current user wrapped up in
> a `current_user` method.

Helpers
----------

### Deleting Comments

In addition to the forms helper, there is also a helper to delete a comment.

```erb
<%= delete_comment_link(comment_object) %>
```

Of course, you can write this manually (or add your own helper) if you'd like
to.

Customization
----------

### Overriding A User Model

PeanutGallery assumes the use of a user model. If you want to override that, you'll need to add the association into your `Comment` model:

```ruby
class Comment < ActiveRecord::Base
  belongs_to :author, :class_name => 'YourUserClassName'
end
```

### Controller Actions

The controller doing all the work for PeanutGallery is the
`PeanutGallery::CommentsController`. If you want to override it, you can create
a controller at `app/controllers/peanut_gallery/comments_controller.rb`.

Contributing
----------

1. Fork it ( https://github.com/[my-github-username]/peanut_gallery/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
