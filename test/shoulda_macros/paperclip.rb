require 'paperclip/matchers'
require 'action_controller'

module Paperclip
  # =Paperclip Shoulda Macros
  #
  # These macros are intended for use with shoulda, and will be included into
  # your tests automatically. All of the macros use the standard shoulda
  # assumption that the name of the test is based on the name of the model
  # you're testing (that is, UserTest is the test for the User model), and
  # will load that class for testing purposes.
  module Shoulda
    include Matchers
    # This will test whether you have defined your attachment correctly by
    # checking for all the required fields exist after the definition of the
    # attachment.
    def should_have_attached_file name
      klass   = self.name.gsub(/Test$/, '').constantize
      matcher = have_attached_file name
      should matcher.description do
        assert_accepts(matcher, klass)
      end
    end

    # Tests for validations on the presence of the attachment.
    def should_validate_attachment_presence name
      klass   = self.name.gsub(/Test$/, '').constantize
      matcher = validate_attachment_presence name
      should matcher.description do
        assert_accepts(matcher, klass)
      end
    end

    # Tests that you have content_type validations specified. There are two
    # options, :valid and :invalid. Both accept an array of strings. The
    # strings should be a list of content types which will pass and fail
    # validation, respectively.
    def should_validate_attachment_content_type name, options = {}
      klass   = self.name.gsub(/Test$/, '').constantize
      valid   = [options[:valid]].flatten
      invalid = [options[:invalid]].flatten
      matcher = validate_attachment_content_type(name).allowing(valid).rejecting(invalid)
      should matcher.description do
        assert_accepts(matcher, klass)
      end
    end

    # Tests to ensure that you have file size validations turned on. You
    # can pass the same options to this that you can to 
    # validate_attachment_file_size - :less_than, :greater_than, and :in.
    # :less_than checks that a file is less than a certain size, :greater_than
    # checks that a file is more than a certain size, and :in takes a Range or
    # Array which specifies the lower and upper limits of the file size.
    def should_validate_attachment_size name, options = {}
      klass   = self.name.gsub(/Test$/, '').constantize
      min     = options[:greater_than] || (options[:in] && options[:in].first) || 0
      max     = options[:less_than]    || (options[:in] && options[:in].last)  || (1.0/0)
      range   = (min..max)
      matcher = validate_attachment_size(name).in(range)
      should matcher.description do
        assert_accepts(matcher, klass)
      end
    end

    def stub_all_s3_for_paperclip_model(klass)
      attachment_definitions = klass.read_inheritable_attribute(:attachment_definitions)
      attachment_definitions.each do |attachment_name, definition|
        next unless definition[:storage].to_s == "s3"

        path = "http://s3.amazonaws.com/#{definition[:bucket]}/#{definition[:path]}"

        regexp = Regexp.escape(path)
        regexp.gsub!(/:attachment/,   attachment_name.to_s.underscore.pluralize)
        regexp.gsub!(/:class/,        klass.name.tableize)

        if definition[:styles]
          styles = definition[:styles].keys.map(&:to_s) + ["original"]
          regexp.gsub!(/:style/, "(#{styles.join('|')})")
        end
        regexp.gsub!(/:id/,           '\d+')
        regexp.gsub!(/:id_partition/, '\d+\/\d+\/\d+')
        regexp.gsub!(/:rails_env/,    Rails.env)
        regexp.gsub!(/:rails_root/,   Rails.root)
        regexp.gsub!(/:[^\/]+/,      '[^\/]+')
        FakeWeb.register_uri(:any, Regexp.new(regexp), :body => "OK")
      end
    end
  end
end

class Test::Unit::TestCase #:nodoc:
  extend Paperclip::Shoulda
end
