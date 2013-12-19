---
date: 2007-02-21 12:00 PDT
title: First rails patch!
description: A man rejoices over someone accepting his first Ruby on Rails patch.
---

A [co-worker](http://workingwithrails.com/person/1556-jon-yurek) and I over at [thoughtbot](http://www.thoughtbot.com) are working on an application that makes heavy use of the newish REST resources.  While `map.resources` is hella beautiful and a serious code-saver, we found that a small addition would make it even more so.

A relatively little known fact about the rails routing helpers is that they use the `ActiveRecord#to_param` method for the id value.  This means you can have the `to_param` method of a user object return the `username`, and access that resource as `/users/georgebushlol`.  The problem is that you still have controller methods that look like this:

~~~ ruby
def show
  @user = User.find_by_username(:id)
end
~~~

...when what you'd really like is this:

~~~ ruby
def show
  @user = User.find_by_username(:username)
end
~~~

We [submitted a patch](http://dev.rubyonrails.org/ticket/6814) to Rails that adds the ability to change the name of the `:id` parameter in the RESTFull routes.  It adds a parameter named `:key` to the options for `map.resources`, which specifies a name to be used instead of `:id` in all member urls. 

If the value doesn't start with the singular name of the resource (such as `:name`), then `'[resource]_'` will be prepended to it when nested (more on that later). Here's an example:

~~~ ruby
map.resources :clients, :key => :client_name do |client|
  client.resources :sites, :key => :name do |site|
    site.resources :articles, :key => :title
  end
end
~~~

These routes create the following paths:

~~~
/clients/:client_name
/clients/:client_name/sites/:name
/clients/:client_name/sites/:site_name/articles/:title
~~~

Notice that because `'client_name'` starts with `'client'` (singular version of the controller), the nested path parameter remains `'client_name'`, and is not automatically set to `'client_client_name'` (which would be dumb). The example above shows the full range of the `:key` option, but common usage would be more in line with this:

~~~ ruby
map.resources :users, :key => :user_id do |user|
  user.resources :books, :key => :isbn do |book|
    book.resources :authors
  end
end
~~~

The path to parameterized path mappings for these routes are:

~~~
/users/2 => /users/:user_id
/users/2/books/0-12-345678-9 => /users/:user_id/books/:isbn
/users/2/books/0-12-345678-9/authors/3 => /users/:user_id/books/:book_isbn/authors/:id
~~~

In addition, we find that our code can be greatly simplified when the keys in the `params` hash are always referring to the same models. Normally `:id` can refer to any of your model classes, depending on which controller you're in. If you specify a `:key` value of `:XXX_id` for each resource, however, then you can move a good deal of your code to helper methods which can be used globally:

~~~ ruby
def get_user
  @user ||= User.find(params[:user_id])
end
~~~

Consistent use of these helpers really helps the readability of you application.

The patch includes pretty good tests, and we've been using it for the past few months in three of our production applications.  If you'd like to see it in rails 1.3, please [head on over](http://dev.rubyonrails.org/ticket/6814) and vote for it.
