class MyRedClothTemplate < Tilt::RedClothTemplate
  BASE_IMAGE_URL = "/images"
  include Padrino::Helpers::TagHelpers

  def prepare
    @engine = RedCloth.new(image_filter(code_filter(data)))
    @output = nil
  end

  private

  def code_filter(txt)
    txt.gsub(/@@@ *(\w*)\r?\n? *(.+?)\r?\n?@@@/m) do
      klass = $1.present? ? " class=\"#{$1.downcase}\"" : ""
      "<pre><code#{klass}>#{$2}</code></pre>"
    end
  end

  def image_filter(txt)
    txt.gsub(/^%([<>]?)([0-9a-zA-Z_.-]+)([^%]*)%/) do
      float    = $1
      image_id = $2
      size     = $3

      float = :right if float == '>'
      float = :left  if float == '<'

      uploaded_image_tag(image_id, :size => size, :float => float)
    end
  end

  def uploaded_image_tag(image_name, opts = {})
    opts.symbolize_keys

    opts[:size] = "original" if opts[:size].blank?
    opts[:size].strip!

    basename, ext = image_name.split('.')
    image_src = "#{BASE_IMAGE_URL}/#{basename}/#{opts[:size]}.#{ext}"
    meta = meta_for_image(basename)

    return "<div class='warning'>unknown image #{image_name}</div>" unless File.directory?(image_basedir(basename))

    image_options = { :src => image_src }
    image_options[:class] = "float-#{opts[:float]}" if opts[:float]
    image_options[:alt]   = meta[:description] if meta[:description]

    href = meta[:source_url]

    img_tag = content_tag :img, "", image_options
    if href
      return "<a href='#{href}'>#{img_tag}</a>"
    else
      return img_tag
    end
  end

  def image_basedir(basename)
    File.join(TammerSaleh.settings.public, BASE_IMAGE_URL, basename)
  end

  def meta_for_image(basename)
    file = File.join(image_basedir(basename), "meta.yml")
    if File.exist?(file)
      YAML.load_file(file).delete_if {|k, v| v.blank? }
    else
      {}
    end
  end

  # Required to confuse padrino
  def block_is_template?(_)
    false
  end
end
