---
date: 2007-10-23 12:00 PDT
title: Almost Painless Nested Resources
---

It's often the case that you have a restful resource that needs to be accessible nested, and at root.  For example, let's say we have a storefront with a bunch of users and products.  Each user can play with their own products, and the admin users can play with everyone's products.  You've got a `:products` resource at root, and a nested version to scope it under `:users`.

~~~ ruby
# Admin see all products at /products 
map.resources :products

map.resources :users do |users|
  # Users see theirs at /users/:id/products
  users.resources :products, :name_prefix => "user_"
end
~~~

That's all fine and dandy, but your controller is gonna get really messy, real quick...

~~~ ruby
class ProductsController < ApplicationController
  def index
    if params[:user_id]
      @products = User.find(params[:user_id]).products
    else
      @products = Product.find(:all)
    end
  end

  def show
    if params[:user_id]
      @products = User.find(params[:user_id]).products.find(params[:id])
    else
      @products = Product.find(params[:id])
    end
  end
  #...
end
~~~

Now, you'll immediately see that this can be dried up fairly nicely by taking advantage of the duck-similarities between Product and @user.products:

~~~ ruby
class ProductsController < ApplicationController
  before_filter :load_user

  def index
    @products = products.find(:all)
  end

  def show
    @products = products.find(params[:id])
  end
  #...

  private
  def load_user
    @user = User.find_by_id(params[:user_id])
  end

  def products
    `user ? `user.products : Product
  end
end
~~~

This is definitely a step in the right direction.  But we get a real good kick in the face by our ActiveRecord associations.  Instead of defining `user.products.new()`, they went with `user.products.build()`, completely un-drying our `:new` and `:create` actions!

Now, this will be fixed by a simple `:alias_method` call in Rails 2.0, but since we're sticking with stable code for now, we'll have to do it by hand.

~~~ ruby
module ActiveRecord
  module Associations
    class HasManyThroughAssociation
      alias_method :new, :build
    end
    class HasManyAssociation
      alias_method :new, :build
    end
    class HasAndBelongsToManyAssociation
      alias_method :new, :build
    end
  end
end
~~~

Just put that in your `/lib`, and require it.  Now you've got yourself a painless nested (or non) resource:

~~~ ruby
class ProductsController < ApplicationController

  before_filter :load_user
  before_filter :authorize

  def index
    @products = products.search(params[:search])
  end

  def show
    @product = products.find(params[:id])
  end

  def new
    # This might use our alias...  or it might not...  how exciting!
    @product = products.new
  end

  def edit
    @product = products.find(params[:id])
  end

  def create
    # Once again, meta programming to the rescue!
    @product = products.new(params[:product])

    if @product.save
      flash[:notice] = :success
      redirect_to_product(@product)
    else
      render :action => "new"
    end
  end

  def update
    @product = products.find(params[:id])

    if @product.update_attributes(params[:product])
      flash[:notice] = :success
      redirect_to_product(@product)
    else
      render :action => "edit"
    end
  end

  def destroy
    @product = products.find(params[:id])

    @product.destroy
    flash[:notice] = :success
    redirect_to_collection
  end

  private

  def authorize
    # blah blah deny access...
  end

  def load_user
    @user = User.find_by_id(params[:user_id])
  end

  def products
    `user ? `user.products : Product
  end

  # These are just sugar...
  def redirect_to_collection
    redirect_to(`user ? user_products_url(`user) : products_url)
  end

  def redirect_to_product(p)
    redirect_to(p.user ? user_product_url(p.user, p) : product_url(p))
  end
end
~~~

This should prove even easier with all of the resource and url changes coming in Rails 2.0.
