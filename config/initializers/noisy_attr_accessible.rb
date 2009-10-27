ActiveRecord::Base.class_eval do
  def log_protected_attribute_removal(*attributes)
    raise "#{self.class}: Can't mass-assign these protected attributes: #{attributes.join(', ')}"
  end
end
