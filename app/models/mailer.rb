class Mailer < ActionMailer::Base
  default_url_options[:host] = HOST

  def new_comment(comment)
    subject    "[Blog] comment on \"#{comment.post}\""
    recipients 'Tammer Saleh <tsaleh+comments@gmail.com>'
    from       'notifier@tammersaleh.com'
    body       :comment => comment
  end
end

