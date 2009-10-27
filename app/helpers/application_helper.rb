# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def body_class
    "#{controller.controller_name} #{controller.controller_name}-#{controller.action_name}"
  end
end
