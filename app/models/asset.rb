class Asset < ActiveRecord::Base
  attr_accessible :asset, :asset_file_name, :description, :asset_content_type

  has_attached_file :asset, 
                    :url => "/system/assets/:basename.extension",
                    :path => ":rails_root/public/system/assets/:basename.extension"
  
  def to_s
    File.basename(asset_file_name)
  end
end
