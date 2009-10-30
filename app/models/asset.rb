class Asset < ActiveRecord::Base
  attr_accessible :asset, :asset_file_name, :description, :asset_content_type

  has_attached_file :asset, 
                    :storage        => :s3, 
                    :bucket         => ENV['S3_BUCKET'],
                    :path           => ":rails_env/:class/:basename.:extension",
                    :s3_credentials => { :access_key_id     => ENV['S3_KEY'], 
                                         :secret_access_key => ENV['S3_SECRET'] }
  def to_s
    File.basename(asset_file_name)
  end
end
