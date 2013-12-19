---
date: 2009-04-15 12:00 PDT
title: Domain Explosion
description: A discourse on the explosion of classes that can result from applying Java techniques to your Ruby on Rails codebase.
---

There's an AntiPattern that I still see in the wild far too often: the overly normalized domain.  It's easy to spot - you find over 50 files staring you down after opening the `app/models` directory in what should have been a basic Rails application.

A simple example is the following domain snippet, showing a Product model with all the trappings that surround it.

![Image](Untitled/original.jpg)
{: .img_left}

Each of `Condition`, `Color`, `ProductState` and `ShippingType` are separate models, with separate tables, separate factory definitions, unit tests, RESTful controllers, migrations, etc.

*And each is responsible for a single `name` column.*

That's a lot of code.  The more code I see in an application, the sorrier I feel for the client.  **Code is a liability**.  Like a pack mule, the development process becomes bogged down, cumbersome, and eventually comes to a halt due to an overburden of code.

A much simpler solution is to reduce each of those models into columns on `Product`, using validations and named scopes to give all the benefits of the domain above:

~~~ ruby
class Product < ActiveRecord::Base
  COLORS = %w(Red White Blue)

  named_scope :colored, lambda {|c| {:conditions => {:color => c}}}
  validates_inclusion_of :color, :in => COLORS
end
~~~

Even the `Photo` model can be reimplemented this way, if you use the fantastic [Paperclip](http://github.com/thoughtbot/paperclip) plugin.

### Developers, not coders.

It sounds absurd and even self defeating, but our job as developers isn't to write code.  Our job is to produce value for the client, and more often than not that means removing code.

That requires a whole lot of judgment, which translates to a whole lot of experience.

### Behavior, not nouns.

The idea of removing classes in favor of values doesn't fly in the face of good Object Oriented practices.  The important distinction is that the classes above have essentially no behavior.  A class without behavior is just a glorified value wrapped in maintenance costs.

*Behavior, not vocabulary, dictates normalization.*  The moment you add a `shipping_rate` method to the `Product` model, you know you should migrate to a `ShippingType` class.  The moment you have to be able to modify that price at runtime, you move to a model.

### Simplest thing possible.

That's the beauty of the [BDD](http://behaviour-driven.org/) way.  BDD teaches you to write your specs first, and produce the *simplest thing possible* in order to get them to pass.  It also keeps you focused on producing business value for your client - something a domain explosion definitely doesn't do.

### The Plug

[Chad Pytel](http://thoughtbot.com/about/people#cpytel) and I delve into issues just like this in our upcoming Addison Wesley book, [Rails AntiPatterns](http://my.safaribooksonline.com/9780321620293).  [Stay tuned](http://feeds.feedburner.com/TammerSaleh) for more information on the book, or for more posts like this.
