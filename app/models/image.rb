class Image < ActiveRecord::Base
  attr_accessible :image_content_type, :image_file_name, :image, :description, :source_url

  has_attached_file :image, 
                    :storage        => :s3, 
                    :bucket         => ENV['S3_BUCKET'],
                    :path           => ":rails_env/:class/:id-:style.:extension",
                    :styles => { :thumb => "64x64", :medium => "200x200", :large => "400x400" },
                    :s3_credentials => { :access_key_id     => ENV['S3_KEY'], 
                                         :secret_access_key => ENV['S3_SECRET'] }
  def to_s
    File.basename(image_file_name)
  end
end
