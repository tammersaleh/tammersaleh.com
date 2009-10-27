class ActiveSupport::TestCase
  include ActionController::Assertions::SelectorAssertions

  def assert_select_in(html, *args, &block)
    node = HTML::Document.new(html).root
    assert_select(*args.unshift(node), &block)
  end
end

