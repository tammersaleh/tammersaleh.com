class PageCollection < Array
  attr_accessor :collection_root

  def initialize(collection_root)
    super()
    self.collection_root = collection_root
    self.concat(pages)
  end

  private

  def pages
    unsorted_pages.sort_by do |page|
      page.meta[:date]
    end.reverse
  end

  def unsorted_pages
    page_template_paths.map do |file_path|
      Page.new(file_path)
    end
  end

  def page_template_paths
    page_files.map do |full_path|
      template_path_for(full_path)
    end
  end

  def template_path_for(full_path)
    full_path[views_root]  = ""
    full_path[%r{\.[^/]*}] = ""
    full_path
  end

  def page_files
    Dir[File.join(pages_root, "**/*")]
  end

  def pages_root
    File.join(views_root, collection_root)
  end

  def views_root
    TammerSaleh.settings.views
  end
end
