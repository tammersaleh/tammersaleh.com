module Slugalicious
  Infinity = 1.0/0

  def self.included(klass)
    klass.extend(ClassMethods)

    klass.class_eval do
      validates_presence_of :slug
      validates_uniqueness_of :slug
      validates_format_of :slug, :with => %r{^[a-zA-Z0-9_-]+$}

      before_validation :set_slug_from_title
    end
  end

  def to_param
    slug
  end

  def set_slug_from_title
    if self.title and self.slug.blank?
      s = self.title.gsub(/[^0-9a-zA-Z_]/, '-').downcase.gsub(/-+/, '-').gsub(/-$/, '').gsub(/^-/, '')
      self.slug = uniquify_slug(s)
    end
  end

  def uniquify_slug(s)
    return s unless self.class.exists?(:slug => s)
    (2...Infinity).each do |i|
      new_slug = "#{s}-#{i}"
      return new_slug unless self.class.exists?(:slug => new_slug)
    end
  end

  module ClassMethods
    def find(*args, &blk)
      slug = args.first if not args.empty?
      if slug.is_a?(String) and element = find_by_slug(slug)
        return element
      end
      super
    end
  end
end
