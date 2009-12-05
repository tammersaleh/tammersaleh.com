require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  %w(about coding_standards hire interview_questions speaking).each do |page|
    context "on GET to /pages/#{page}" do
      setup { get :show, :id => page }
  
      should_not_set_the_flash
      should_render_template page
      should_render_with_layout "home"
    end
  end
end

