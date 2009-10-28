class Image < ActiveRecord::Base
  attr_accessible :image_content_type, :image_file_name, :image, :description, :source_url

  has_attached_file :image, 
                    :url => "/system/images/:style/:basename.:extension", 
                    :path => ":rails_root/public/system/images/:style/:basename.:extension", 
                    :styles => { :thumb => "64x64", :medium => "200x200", :large => "400x400" }
  
  def to_s
    File.basename(image_file_name)
  end
end
