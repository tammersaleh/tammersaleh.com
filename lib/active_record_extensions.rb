class ActiveRecord::Base
  named_scope :ordered, :order => "created_at DESC"
  named_scope :limit,   lambda { |limit| { :limit => limit } }
end
