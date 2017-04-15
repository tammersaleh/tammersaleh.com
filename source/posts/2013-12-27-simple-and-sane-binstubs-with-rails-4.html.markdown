---
title: Simple and Sane Binstubs with Rails 4
date: 2013-12-27 12:46 PST
description: "Bundler binstubs and Rails 4 can play well together.  Here's how."
---

With version 4.0 of the Ruby on Rails framework, [executables such as `bin/bundle`, `bin/rails`, and `bin/rake` are installed in the project's `bin` directory](http://edgeguides.rubyonrails.org/4_0_release_notes.html#railties-notable-changes) by default (and via `rake rails:update:bin`).  These executables had previously been installed in the poorly chosen `script` directory.  

This is a good change, but causes issues for those of us who have been using the convention of installing bundler binstubs in the `bin` directory.  Here's some history and a simple and more orthodox solution.

## Why binstubs?

Mislav wrote a wonderful and in-depth article ["explaining binstubs and their many uses"](https://github.com/sstephenson/rbenv/wiki/Understanding-binstubs).  For our purposes, it's enough to understand that binstubs are a way of removing the need to type `bundle exec` before each and every command.

If you simply type `rspec` on the commandline, you'll execute the first `rspec` bash finds in your `$PATH`, which is likely the script that rubygems installed when you installed the gem.  That script ([itself a binstub](https://github.com/sstephenson/rbenv/wiki/Understanding-binstubs#rubygems)) will find the *latest version* of rspec and execute that.  This completely ignores your `Gemfile`, which can lead to confusing and unexpected errors.

To address this, Bundler added its own support for project-specific binstubs.  Running `bundle install --binstubs` will add another 

XXX This is all wrong :(
