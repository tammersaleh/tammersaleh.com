---
date: 2009-08-12 12:00 PDT
title: The problem isn't your tests...
---

##### ...the problem is your scaffolding.

*A rebuttle to [Unpopular Developer 5: Stop Unit Testing Your Scaffold Controllers](http://robots.thoughtbot.com/post/161331097/unpopular-developer-5-stop-unit-testing-your-scaffold)*

[Mike Burns](http://mike-burns.com/work/) of [Thoughtbot](http://thoughtbot.com) argues that we should no longer be writing unit tests for the default scaffolding for our RESTful controllers.

> **Stop unit testing the RESTful scaffold.**
> 
> Do write an integration test with Webrat (and Cucumber or Rails integration tests or some crazy script using Hubris), but abstract that out as much as you can. It’s the scaffold. You know it works.
> 
> You should write a unit test for your RESTful controller as soon as it deviates, and you should test-drive that deviation both in the integration test and the unit test.


While the point is well intentioned, I believe he hasn't delved far enough into why we've ended up writing tests for behavior that is this predictable.  More to the point, **why are we writing predictable behavior at all?**

Let's step back a bit and look at a parallel situation.  When we create a new ActiveRecord model, do we test every database querying feature by hand?  Do we write explicit tests that show that `find(1)`, `find_by_id(1)`, and `find(:all)` are working as we expect?  We don't do that because we know that we're using a very well tested and stable library.

But what if Rails had been designed differently?  What if, instead of inheriting from `ActiveRecord::Base`, we ran a generator that produced all the database access code for us, inline, in our new model?  This is clearly a worse situation - we now have the temptation of modifying that code to suite our needs.  Did the developer before us use a standard validation, or override `#save` by hand?  Did he remove any of the default functionality?

In this situation, we'd need to test each and every feature generated for us in our unit tests.  We'd probably even attempt a [misguided extraction](http://groups.google.com/group/shoulda/browse_thread/thread/21fa2dc934fc7b71/800501cd621ae8d2?lnk=gst&q=should_be_restful#800501cd621ae8d2) that would reduce those tests to a single line, but the tests would still be there.

The root issue in the second scenario isn't that we have to write repetitive tests for our boilerplate code - *It's that we've allowed boilerplate code into our project in the first place.*   There are [better solutions](http://github.com/josevalim/inherited_resources) to this problem. 
