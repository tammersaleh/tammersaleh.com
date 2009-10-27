class PagesController < HighVoltage::PagesController
  skip_before_filter :require_user
end
