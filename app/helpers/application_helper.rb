# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def body_class
    "#{controller.controller_name} #{controller.controller_name}-#{controller.action_name}"
  end

  def page_title(title = nil, &block)
    if title
      @page_title = title
    else
      @page_title = capture(&block)
    end
  end

  def link(item, label = nil, html_opts = nil)
    return "" unless item
    path = "#{item.class.name.underscore}_path"
    parents = item.parents rescue []
    parents << item
    link_to(label || item.to_s, send(path, *parents), html_opts)
  end

  def destroy_link(item, label = "remove", msg = nil, html_opts = nil)
    return "" unless item
    html_opts ||= {}
    msg ||= "Are you sure you want to destroy the #{item.class.name.underscore.humanize.downcase} '#{item}'?  This cannot be undone."
    path = "#{item.class.name.underscore}_path"
    parents = item.parents rescue []
    parents << item
    link_to(label, send(path, *parents), {:method => :delete, :confirm => msg}.merge(html_opts))
  end

  def admin_links_for(item, force = false)
    return "" unless (logged_in? or force)
    
    links = []
    if item.is_a? Class
      new_path = "new_#{item.name.underscore}_path"
      links << link_to("Add #{item}", send(new_path))
    else
      edit_path = "edit_#{item.class.name.underscore}_path"
      links << link_to("edit", send(edit_path, item))
      links << destroy_link(item)
    end
    '<span class="admin_links">(' + links.join(", ") + ')</span>'
  end
  
  def unfinished
    mile "unfinished"
  end  

  def code_filter(txt)
    txt.gsub(/@@@ *(\w*)\r?\n? *(.+?)\r?\n?@@@/m) do
      # code = $2.gsub(/(^\n*|\n*$)/m, '')
      klass = $1.present? ? " class=\"#{$1.downcase}\"" : ""
      "<pre><code#{klass}>#{$2}</code></pre>"
    end
  end

  def image_filter(txt)
    txt.gsub(/%([<>]?)([0-9a-zA-Z_.-]+)([^%]*)%/) do
      float    = $1
      image_id = $2
      size     = $3.blank? ? :original : $3.strip.to_sym

      if image = Image.find_by_image_file_name(image_id)
        image_options = { :src => image.image.url(size), :alt => image.description }
        image_options[:class] = "clear"
        image_options[:class] << " float-right" if float == '>'
        image_options[:class] << " float-left"  if float == '<'

        url_options = { :href => image.source_url }

        if image.source_url?
          content_tag :a, url_options do
            content_tag :img, "", image_options
          end
        else
          content_tag :img, "", image_options
        end
      else
        "<p><strong>Could not find image named #{$2}</strong></p>"
      end
    end
  end

  def submitter_link(comment)
    if comment.submitter_url?
      link_to h(comment.submitter_name), comment.submitter_url
    else
      h(comment.submitter_name)
    end
  end

  def my_comment_class(comment)
    if comment.submitter_url =~ /tammersaleh.com/
      "by-owner"
    else
      ""
    end
  end

  def comment_format(txt)
    auto_link(RedCloth.new(code_filter(strip_tags(txt || ""))).to_html)
  end

  def page_format(txt)
    RedCloth.new(image_filter(code_filter(txt || ""))).to_html
  end

  def post_format(txt)
    RedCloth.new(image_filter(code_filter(txt || ""))).to_html
  end
end
