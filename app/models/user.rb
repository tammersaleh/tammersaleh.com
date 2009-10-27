class User < ActiveRecord::Base
  attr_accessible :name, :email, :photo, :password, :password_confirmation

  acts_as_authentic do |config|
    config.validate_password_field = false
    config.validate_email_field    = false
  end

  has_attached_file :photo, 
                    :storage        => :s3, 
                    :bucket         => ENV['S3_BUCKET'],
                    :path           => ":rails_env/:class/:id/:attachment/:style.:extension",
                    :default_url    => "/images/default_:style_avatar.jpg",
                    :default_style  => :small,
                    :styles         => { :small  => "64x64#", 
                                         :medium => "128x128#" },
                    :s3_credentials => { :access_key_id     => ENV['S3_KEY'], 
                                         :secret_access_key => ENV['S3_SECRET'] }

  named_scope :active, :conditions => {:active => true}

  validates_presence_of :password, :if => :require_password?
  validates_confirmation_of :password, :if => :password_changed?
  validates_presence_of :email
  validates_presence_of :name, :if => :active?

  after_create :send_activation_email, :unless => :active?

  def require_password?
    active? and crypted_password.blank?
  end

  def to_s
    name
  end

  def destroy
    self.active = false
    save!
  end

  private

  def send_activation_email
    Mailer.deliver_user_activation(self)
  end
end

