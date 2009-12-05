class Page < ActiveRecord::Base
  include Slugalicious

  attr_accessible :title, :body, :published, :description

  validates_presence_of :title, :body

  named_scope :ordered, :order => "title"
  named_scope :show_unpublished, lambda {|admin| admin ? {} : { :conditions => { :published => true } } } 

  def to_s
    title
  end
 
end
