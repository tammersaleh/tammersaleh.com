---
date: 2008-07-29 12:00 PDT
title: Testing named_scope
description: An announcement that Shoulda now has support for testing your named_scopes.
---

We're huge fans of `NamedScope` here at Thoughtbot.  It does wonders for finder reuse and clarity.  Unfortunately, it also creates a large number of finders that all must be tested, where the old method may have only created one.

To help out with the testing of simple `named_scope` definitions, we added a helper to [Shoulda](http://thoughtbot.com/projects/shoulda), `should_have_named_scope`:

~~~ ruby
class User < ActiveRecord::Base
  named_scope :old,      :conditions => "age > 50"
  named_scope :eighteen, :conditions => { :age => 18 }
  named_scope :recent,   lambda {|count| { :limit => count } }
end

class UserTest < Test::Unit::TestCase
  should_have_named_scope :old,       :conditions => "age > 50"
  should_have_named_scope :eighteen,  :conditions => { :age => 18 }
  should_have_named_scope 'recent(5)', :limit => 5
  should_have_named_scope 'recent(1)', :limit => 1
end
~~~

Now for complex methods, where the options returned by the `has_finder` are hairier than a simple limit or a single column condition, we would also write black box tests.  But this helper is great for those simpler calls.
