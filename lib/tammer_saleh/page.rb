class Page
  YAML_REGEXP = /^(---\s*\n.*?\n?)^(---\s*$\n?)/m

  attr_reader :request_path, :views_root, :meta, :source

  def initialize(request_path)
    @views_root    = TammerSaleh.settings.views
    @request_path  = request_path
    @entire_source = File.read(template_path)
    @meta, @source = split_body
  end
  
  def html
    Tilt[template_path].new { @source }.render
  end

  private

  def split_body
    data = {}
    if @entire_source =~ YAML_REGEXP
      data = hash_from_yaml($1)
      body = @entire_source.split(YAML_REGEXP).last
    end

    [HashWithIndifferentAccess.new(data), body]
  end

  def hash_from_yaml(yaml)
    begin
      return YAML.load(yaml)
    rescue ArgumentError => e
      raise e, "#{e.message}:\n#{yaml.inspect}"
    end
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

