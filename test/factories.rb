Factory.sequence(:email) {|n| "none#{n}@example.com" }
Factory.sequence(:url)   {|n| "http://www.google#{n}.com/" }

Factory.define :user do |f|
  f.name "Bob"
  f.email { Factory.next(:email) }
  f.password "changeme"
  f.password_confirmation {|user| user.password }
  f.active true

  # Necessary to keep authlogic from 
  # logging in each user as we create them.
  f.skip_session_maintenance true
end

Factory.define :inactive_user, :class => "User" do |f|
  f.email { Factory.next(:email) }
  f.active false
end

Factory.define :post do |f|
  f.title "This is the title."
  f.body  "This is the body."
end

Factory.define :page do |f|
  f.title "This is the title."
  f.body  "This is the body."
end

Factory.define :comment do |f|
  f.association     :post
  f.submitter_name  "Bob"
  f.submitter_email "bob@bob.com"
  f.body            "This is the body."
end

Factory.define :image do |f|
  f.image File.new(File.join(Rails.root, "test", "fixtures", "file.jpg")) 
end

Factory.define :asset do |f|
  f.asset File.new(File.join(Rails.root, "test", "fixtures", "file.jpg")) 
end

