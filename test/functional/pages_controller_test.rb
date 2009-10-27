require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  as_a_visitor do
    %w(home).each do |page|
      context "on GET to /pages/#{page}" do
        setup { get :show, :id => page }

        should_respond_with :success
        should_render_template page
      end
    end
  end
end

