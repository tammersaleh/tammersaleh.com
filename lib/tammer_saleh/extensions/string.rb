class String
  def unindent
    gsub /^#{self[/\A\s*/]}/, ''
  end
  
  def uncomment(comment = "//")
    gsub(%r{^#{comment}\s*}, '')
  end
end

