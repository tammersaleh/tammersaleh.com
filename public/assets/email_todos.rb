#!/usr/bin/env ruby

NAME            = 'tammersaleh'
EMAIL           = 'Tammer Saleh <tsaleh@gmail.com>'
KEY             = 'this is the key'
SSL             = true
MAILER_SETTINGS = {
  :address => "smtp.gmail.com",
  :port => "587",
  :domain => "localhost.localdomain",
  :authentication => :plain,
  :user_name => "tsaleh",
  :password => "this is the password"
}

# stuff.

require 'rubygems'
require 'redcloth'  
#require 'xmlsimple'
require 'yaml'
require 'net/https'
require 'action_mailer'
require 'tlsmail'

Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
ActionMailer::Base.smtp_settings = MAILER_SETTINGS

# just to get auto_link.  Must be a better way.
require 'action_controller'
include ActionView::Helpers::TextHelper
include ActionView::Helpers::TagHelper

class Backpack
  attr_accessor :username, :token, :current_page_id

  def initialize(username, token, use_ssl = false)
    @username, @token = username, token
    connect(use_ssl)
  end

  def connect(use_ssl = false)
    @connection = Net::HTTP.new("#{@username}.backpackit.com", use_ssl ? 443 : 80)
    @connection.use_ssl = use_ssl
    @connection.verify_mode = OpenSSL::SSL::VERIFY_NONE if use_ssl
  end

  def page_id=(id)
    self.current_page_id = id
  end

  def request(path, parameters = {}, second_try = false)
    parameters = { "token" => @token }.merge(parameters)

    response = @connection.post("/ws/#{path}", parameters.to_yaml, "X-POST_DATA_FORMAT" => "yaml")

    if response.code == "200"
      result = XmlSimple.xml_in(response.body)
      result.delete "success"
      result.empty? ? true : result
    elsif response.code == "302" && !second_try
      connect(true)
      request(path, parameters, true)
    else
      raise "Error occured (#{response.code}): #{response.body}"
    end
  end

  # Pages ----

  def list_pages
    request "pages/all"
  end

  def show_page(page_id = current_page_id)
    request "page/#{page_id}"
  end

end

class Mailer < ActionMailer::Base
  def summary(html)
    recipients      EMAIL
    subject         "Your backpack tasks"
    from            "tammersaleh@tammersaleh.com"
    part :content_type => "text/html", :body => html
  end
end

out = ["h1.  Your Backpack Tasks"]

backpack = Backpack.new(NAME, KEY, SSL)
pages = backpack.list_pages['pages'].first['page']
pages = pages.select {|p| p['title'] =~ /^@/ }

pages.each do |page_hash|
  page_id    = page_hash["id"]
  page_title = page_hash["title"]
  page_url   = (SSL ? 'https://' : 'http://') + "#{NAME}.backpackit.com/page/#{page_id}"

  out << ""
  out << "h2. \"#{page_title}\":#{page_url}"
  out << ""

  page = backpack.show_page(page_id)['page']

  lists = page.first['lists'].first['list'] rescue []
  lists = lists.select {|l| l['name'] == 'Tasks'}

  lists.each do |list|
    items = list['items'].first['item'] rescue []
    items = items.select {|i| i['completed'] == 'false' }
    items = items.map {|i| i['content']}
    items.each do |i|
      out << "* #{auto_link(i)}"
    end
  end
end

Mailer.deliver_summary(RedCloth.new(out.join("\n")).to_html)

