class ActionController::TestCase
  def self.should_not_have_errors_on(ivar_name)
    should "not have errors on #{ivar_name}" do
      assert_equal [], assigns(ivar_name).errors.full_messages
    end
  end
end
