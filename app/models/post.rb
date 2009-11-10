class Post < ActiveRecord::Base
  include Slugalicious

  attr_accessible :published_at, :published, :title, :body, :extended

  has_many :comments, :dependent => :destroy, :order => "created_at"

  validates_presence_of :title
  validates_presence_of :body
  
  named_scope :ordered,          :order      => "published_at DESC"
  named_scope :unpublished,      :conditions => "published_at is null"
  named_scope :show_unpublished, lambda { |admin| 
    admin ? {} : { :conditions => "published_at is not null" } 
  }

  def published?
    !self.published_at.blank?
  end

  def published
    published?
  end

  def published=(bool)
    if ["1", true].include?(bool)
      self.published_at ||= Time.now
    else
      self.published_at = nil
    end
  end

  def to_s
    title
  end
end
