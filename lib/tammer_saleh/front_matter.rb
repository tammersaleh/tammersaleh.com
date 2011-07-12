module FrontMatter
  def first_template_matching(name)
    name_with_extension = Dir[File.join(settings.views, "#{name}.html.*")].first
  end

  def front_matter_from_file(filename)
    if commented_front_matter = file_body(filename)[%r{^//\s*---.*^//\s*---}m]
      commented_front_matter.sub!(%r{^(//\s*---.*^)//\s*---}m, "\1")
      front_matter = commented_front_matter.gsub(%r{^//\s*}, '')
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

  def file_body(file)
    File.read(file)
  end
end

