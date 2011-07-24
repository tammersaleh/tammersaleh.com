class Page
  attr_accessor :request_path, :views_root, :meta

  def initialize(request_path)
    self.views_root    = TammerSaleh.settings.views
    self.request_path  = request_path
    self.meta          = front_matter
  end
  
  def body
    File.read(template_path)
  end

  private

  def front_matter
    hash = {}
    hash = hash_from_yaml(uncommented_front_matter) if commented_front_matter
    HashWithIndifferentAccess.new(hash)
  end

  def hash_from_yaml(yaml)
    begin
      return YAML.load(yaml)
    rescue ArgumentError => e
      raise e, "#{e.message}:\n#{yaml.inspect}"
    end
  end

  def uncommented_front_matter
    commented_front_matter.uncomment
  end

  def commented_front_matter
    body[%r{^(//\s*---.*^)//\s*---}m, 1]
  end
  
  def template_path 
    first_template_matching(request_path)
  end

  def first_template_matching(name)
    pattern    = File.join(views_root, "#{name}.html.*")
    candidates = Dir[pattern]
    raise "Could find no files matching #{pattern}" if candidates.empty?
    candidates.first
  end
end

