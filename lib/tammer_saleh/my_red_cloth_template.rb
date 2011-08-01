class MyRedClothTemplate < Tilt::RedClothTemplate
  def prepare
    @engine = RedCloth.new(code_filter(data))
    @output = nil
  end

  def code_filter(txt)
    txt.gsub(/@@@ *(\w*)\r?\n? *(.+?)\r?\n?@@@/m) do
      klass = $1.present? ? " class=\"#{$1.downcase}\"" : ""
      "<pre><code#{klass}>#{$2}</code></pre>"
    end
  end
end
