---
date: 2007-08-15 12:00 PDT
title: Specin rSpec with Rails
---

#### Using rSpec / Spec::Rails

Installation is pretty simple, and is fully covered [here](http://rspec.rubyforge.org/documentation/rails/install.html).

Here's an example of some reasonable specs for a product model:

~~~ ruby
context "An instance of Product" do
  fixtures :products

  setup do
    @product = Product.find(:first)
  end

  specify "should return lowest of list_price or our_price when sent price" do
    @product.should_receive(:our_price).and_return(1)
    @product.should_receive(:list_price).and_return(2)
    @product.price.should == 1
  end

  specify "should return highest of price or map_price when sent visible_price" do
    @product.should_receive(:map_price).and_return(1)
    @product.should_receive(:price).and_return(2)
    @product.visible_price.should == 2
  end

  specify "should find love" do
    "shot down".should == "to be loved"
  end
end
~~~

This is just one context from the file.  Here's a screenshot of the output from the whole specification:

![Image](rspec_output_1/original.jpg)

Note the delicate curves of colorization.  Note the simplicity of the context/specification structure.  Wonderful stuff, here.

#### Extending rSpec

Any good testing library needs to be easily extendable -- adding assertions, custom test methods, and all kinds of helpers really eases the developer's fingers.  To that end, I ported some of my model test helpers to rSpec.  Here's how they're used:

~~~ ruby
context "The Product class" do
  model_class Product

  test_required_attributes :title, :sku
  test_unique_attributes :sku
  test_has_and_belongs_to_many :categories, :web_categories, :articles, 
                               :related_products, :accessories, :related_to_products
  test_has_many :alternate_images, :vendables, :synonyms, :metatags
  test_has_many :vendors, :through => :vendables
  test_has_one :image  
end
~~~

And you can see the output in the screenshot above.  Line 6 alone autogenerates six different specifications.  This is very useful.

Unfortunately, getting this to work with rSpec is way more difficult than it should be.  There are two root problems (as far as I can tell):

- The `context` method is defined on Kernel.  This feels dirty, and means that any methods you'd like to add alongside `context` also have to be in Kernel.  I don't think it would have caused too much typing to have to wrap your contexts in a class.
- The context of the `context` block is an object instance, making it fairly difficult to wrap your head around exactly where you should be putting your extra code.  The only [source of information](http://blog.nicksieger.com/articles/2007/01/02/customizing-rspec) I could find about customizing rSpec suggests overriding `before_context_eval`.  This would work for your own helpers, but not for third-party plugins (as they would override each other's changes).

I finally got my plugin working while using the `spec` command, only to see it break everything horribly with the `rake spec` command (which seems to use a completely different Spec::Runner class).  Not good, and giving up.

#### Final Opinions

#### Pros:

- I agree with the general philosophy of thinking in terms of behavior or specifications instead of thinking in terms of tests.  This isn't something intrinsic to rSpec, but it's certainly encouraged by the syntax and output.
- Real sentences as your test names instead of `super_crappy_underscore_filled_ones`.  This is as it should be.
- The ability to have your tests print themselves out as a list of specifications as you run them is super cool.
- Contexts **rock**.  Both in keeping your tests DRY and in improving readability of your specification list.  You could arguably remove fixtures altogether with judicious use of contexts.
- Auto-named tests seem like a fairly good idea, but I didn't have time to play with them enough to say for sure.
- Built-in mocking/stubbing system *(but see below)*
- **Ubiquity matters**: if you're going to bank on a new testing framework becoming the Rails standard, rSpec is probably it. *(but see below)*

#### Cons:

- As I said above, extending rSpec was a serious pain.  It's been my experience that the ability to write test libraries, encompassing paragraphs of code in a single sentence is the real key in improving test coverage and speeding up development time.  This is easily my main gripe with rSpec, and I have high hopes that it will be eliminated as the library matures.
- I actually don't like the `should/should_not` syntax.  "`3.should_not == 4`" is pretty clear, but more complex assertions like "`lambda { do something }.should_raise_error(Exception)`" feel cumbersome compared to their Test::Unit counterparts: "`assert_raises(Exception) { do something }`".  This is a very personal and minor complaint.
- rSpec is not a drop in replacement for the default `rake` task.  This means that any tools that expect the "`86 tests, 329 assertions, 0 failures, 0 errors`" line at the end of your tests (many CI servers, I'm sure) will be lost and confused.
- rSpec comes with its own mocking system, which is great.  Unfortunately, rumor on the internets is that it's incompatible with [mocha/stubba](http://mocha.rubyforge.org/) (my libraries of choice).  Big deal?  Not really.
- **Ubiquity matters**, and while rSpec is definitely the hot new upstart in town, `Test::Unit` is still the ruling king, and had a good head start in terms of mindshare.

While I really like the work the rSpec team is doing, and I expect to see more improvements and cool features fairly soon, the issues above were enough to convince me that it's just not yet ready for me to recommend to my coworkers.  I'm open to debate or commentary, so if you think I've missed anything, just let me know.
