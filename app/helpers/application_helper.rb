# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def body_class
    classes = [controller.controller_name,
               "#{controller.controller_name}-#{controller.action_name}" ]
    classes << "#{controller.controller_name}-#{controller.action_name}-#{params[:id]}" if params[:id]
    classes.join(" ")
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

    image = Image.find_by_image_file_name(image_name)

    return "<p><strong>Could not find image named #{image_name}</strong></p>" unless image

    image_options = { :src   => image.image.url(opts[:size]), 
                      :alt   => image.description,  
                      :class => "clear" }
    image_options[:class] << " float-right" if opts[:float] == :right
    image_options[:class] << " float-left"  if opts[:float] == :left

    url_options = { :href => image.source_url }

    img_tag = content_tag :img, "", image_options
    if image.source_url?
      return content_tag(:a, url_options) { img_tag }
    else
      return img_tag
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
    auto_link(RedCloth.new(code_filter(sanitize(txt || ""))).to_html)
  end

  def page_format(txt)
    RedCloth.new(image_filter(code_filter(txt || ""))).to_html
  end

  def post_format(txt)
    RedCloth.new(image_filter(code_filter(txt || ""))).to_html
  end

  def rss_feed_link(&blk)
    link_to "http://feeds.feedburner.com/TammerSaleh", :rel => "alternate", :type => "application/rss+xml", &blk
  end

  def phone_number_link(text)
    sets_of_numbers = text.scan(/[0-9]+/)
    number = "+1-#{sets_of_numbers.join('-')}"
    link_to text, "tel:#{number}"
  end
end
