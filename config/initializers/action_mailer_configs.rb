ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address              => 'smtp.gmail.com',
  :port                 => 587,
  :authentication       => :plain,
  :user_name            => ENV['GMAIL_USERNAME'],
  :password             => ENV['GMAIL_PASSWORD'],
  :domain               => HOST
}

