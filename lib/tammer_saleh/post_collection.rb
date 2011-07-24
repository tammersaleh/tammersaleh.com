class PostCollection
  def empty?
    post_files.empty?
  end

  def posts
    unsorted_posts.sort_by do |post|
      post.meta[:date]
    end.reverse
  end

  private

  def unsorted_posts
    post_template_paths.map do |file_path|
      Page.new(file_path)
    end
  end

  def post_template_paths
    post_files.map do |full_path|
      template_path_for(full_path)
    end
  end

  def template_path_for(full_path)
    full_path[views_root]  = ""
    full_path[%r{\.[^/]*}] = ""
    full_path
  end

  def post_files
    Dir[File.join(posts_root, "**/*")]
  end

  def posts_root
    File.join(views_root, "posts")
  end

  def views_root
    TammerSaleh.settings.views
  end
end
