class Comment < ActiveRecord::Base
  attr_accessible :post, :body, :submitter_name, :submitter_url, :submitter_email

  is_gravtastic :submitter_email

  belongs_to :post, :counter_cache => "comments_count" 

  validates_presence_of :submitter_name
  validates_presence_of :submitter_email
  validates_presence_of :body
  validates_presence_of :post_id
  validates_format_of :submitter_email, :with => EMAIL_REGEX, :allow_blank => true
  validates_format_of :submitter_url,   :with => URL_REGEX,   :allow_blank => true

  after_create :send_email

  def to_s
    TextHelpers.truncate(body, :length => 10)
  end

  def send_email
    Mailer.deliver_new_comment(self)
  end
end
