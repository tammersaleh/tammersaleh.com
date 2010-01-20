require 'test_helper'

class HelpersTest < ActionView::TestCase
  include ApplicationHelper

  def self.comment_format(txt)
    context "comment_format(#{txt.inspect})" do
      setup { @out = comment_format(txt) }
      yield
    end
  end

  def self.post_format(txt)
    context "post_format(#{txt.inspect})" do
      setup { @out = post_format(txt) }
      yield
    end
  end

  def self.should_contain(regex)
    should "contain #{regex.inspect}" do
      assert_match regex, @out
    end
  end

  def self.should_not_contain(regex)
    should "not contain #{regex.inspect}" do
      assert_no_match regex, @out
    end
  end

  comment_format('http://google.com') { should_contain %r{<a href="http://google.com">http://google.com</a>} }

  comment_format('"hi":http://google.com') do
    should_contain %r{<a href="http://google.com">hi</a>}
  end

  comment_format('<script>blah</script>') do
    should_not_contain %r{<script>}
  end

  comment_format('<a href="foo">blah</a>') do
    should_contain %r{<a href="foo">}
  end

  comment_format("@@@\nblah\n@@@") do
    should_contain '<code>blah</code>'
  end

  comment_format("@@@ ruby\nblah\n@@@\nfoo\n@@@ BASH bar@@@") do
    should_contain '<code class="ruby">blah</code>'
    should_contain '<code class="bash">bar</code>'
  end

  comment_format("@@@ ruby\r\nblah\r\n@@@\r\nfoo\r\n@@@ BASH bar@@@") do
    should_contain '<code class="ruby">blah</code>'
    should_contain '<code class="bash">bar</code>'
  end

  post_format('http://google.com') { should_not_contain %r{<a href} }

  post_format('"hi":http://google.com') do
    should_contain %r{<a href="http://google.com">hi</a>}
  end

  post_format('<script>blah</script>') do
    should_contain %r{<script>}
  end

  post_format("@@@ ruby\nblah\n@@@") do
    should_contain '<code'
  end

  context "when an image named foo exists" do
    setup do
      image = Factory(:image, 
                      :description => "blah",
                      :source_url  => "http://source.com")
      assert_equal "file.jpg", image.reload.image_file_name
    end

    post_format('%>file.jpg%') do
      should_contain %r{src=".*original.*"}
      should_contain %r{alt="blah"}
      should_contain %r{href="http://source.com"}
      should_contain %r{class=".*\bfloat-right\b.*"}
      should_contain %r{class=".*\bclear\b.*"}
    end

    post_format('%file.jpg%') do
      should_not_contain %r{float}
    end

    post_format('%unknown.jpg%') do
      should_contain %r{could not find}i
    end
  end

  context "when an image exists without a source url" do
    setup do
      image = Factory(:image, 
                      :description => "blah")
      assert_equal "file.jpg", image.reload.image_file_name
    end

    post_format('%file.jpg%') do
      should_not_contain %r{<a\b}
    end

    post_format('%file.jpg medium%') do
      should_contain %r{src=".*medium.*"}
    end
  end
end

