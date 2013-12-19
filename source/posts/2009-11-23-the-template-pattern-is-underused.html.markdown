---
date: 2009-11-23 12:00 PDT
title: The Template Pattern is underused
description: A description of the Template Pattern, and how you can make use of it to write better Ruby code.
---

![Image](muji-jigsaw-cookie-cutter/original.jpg)
{:.img_right}

While a large portion of the [Gang of Four software patterns](http://en.wikipedia.org/wiki/Design_Patterns_(book)) are rendered useless by the dynamic nature of Ruby, one that stands the test of time is the [Template Pattern](http://en.wikipedia.org/wiki/Template_method_pattern).

### Simplicity is king.

Simplicity is the stalwart of good software development.  In every case, a responsible developer will search for the simplest solution to a problem.

The beauty of the Template Pattern lies in its simplicity.  While the full description is verbose and sleep inducing, the pattern is very simple: Enable easily configurable behavior by separating the steps of a process into (sometimes empty) methods that a subclass can override.  Here's a quick example:

~~~ ruby
module SandwichMaker
  def make_sandwich
    assemble(find_bread, find_filling, find_condiments)
  end

  def find_bread;      "Wonder";  end
  def find_fillings;   "Ham";     end
  def find_condiments; "Mustard"; end

  def assemble(bread, filling, condiments)
    # control robotic arm...  whatever.
  end
end

class NormalSandwich
  include SandwichMaker
end

class BolognaSandwich
  include SandwichMaker

  def find_fillings
    return "bologna"
  end
end
~~~

Inheritance, method overriding...  This should look totally familiar and fairly boring.  But the outcome is perfect:  The `BolognaSandwich` class can make its namesake without resorting to a DSL, blocks, meaeeaeaetaprogramming, or whatever.  It's just a bunch of methods.

### We should totally do this shit!

Let's look at another one of my favorite tools, [Inherited Resources](http://github.com/josevalim/inherited_resources).  Here's a snippet from one of my Inherited Resources controllers:

~~~ ruby
class NotesController < InheritedResources::Base
  def create
    create! do |success, failure|
      success.html { redirect_to some_other_url }
    end
  end
end
~~~

Now, personally, I find this DSL to be fairly terrible.  What's with the `create!` method inside the `create` method?  The template pattern would have been a better approach:

~~~ ruby
class NotesController < InheritedResources::Base
  def url_for_redirect_after_successful_create
    some_other_url
  end
end
~~~

It's totally clear what that method does, there's zero magic going on, and the implementation would likely be much simpler.

*By the way: anyone who has an issue with a method name that long can go back to Perl.*

### Cautions

There are some issues to be aware of when using the Template Pattern.  

The main issue with implementing a useful and readable template is in determining just where to break out behavior into overrideable methods.  Give the end user too few hooks, and at some point they will be forced to override the entire method.  Include too many hooks, and your implementation is littered with method calls - increasing maintenance costs.

Another place where the Template Pattern falls short is when behavior must be chained.  A great example of this is in `ActiveRecord` callbacks.  You *can* override `before_save`, but doing so is generally recognized as being an [antipattern](http://my.safaribooksonline.com/9780321620293), since all the behavior that should happen at that time must be crammed into that method.  The "right way" of adding callbacks is through the `before_save :method_name` calls.  They chain onto each other in a graceful and maintainable fashion.
