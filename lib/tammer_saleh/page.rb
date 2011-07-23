class Page
  attr_accessor :request_path, :views_root

  def initialize(request_path)
    self.views_root    = TammerSaleh.settings.views
    self.request_path  = request_path
  end
  
  def first_template_matching(name)
    pattern    = File.join(views_root, "#{name}.html.*")
    candidates = Dir[pattern]
    candidates.first
  end

  def front_matter
    if commented_front_matter = body[%r{^(//\s*---.*^)//\s*---}m, 1]
      front_matter = commented_front_matter.uncomment
      begin
        hash = YAML.load(front_matter)
      rescue ArgumentError => e
        raise e, "#{e.message}:\n#{front_matter.inspect}"
      end
    else
      hash = {}
    end
    HashWithIndifferentAccess.new(hash)
  end

  def template_path 
    first_template_matching(request_path)
  end

  def body
    File.read(template_path)
  end
end

