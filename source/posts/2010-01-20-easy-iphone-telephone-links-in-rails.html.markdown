---
date: 2010-01-20 12:00 PDT
title: Easy iPhone telephone links in Rails
description: A technique for making telephone links in your Ruby on Rails applications that can dial an iPhone.
---

Some sites, when viewed through an iPhone, have clickable phone numbers, which can be dialed immediately.  

![Image](iphone-tel-link/original.jpg)

Some sites, on the other hand, require the user to copy the phone number and paste it into the dialer manually.   

### Which ones do you think get more phone calls?

The secret to the clickable phone numbers lies in [RFC 3966](http://www.ietf.org/rfc/rfc3966.txt), which defines the `tel:` link format.  Here's a quick helper that makes `tel:` links a breeze.

~~~ ruby
module ApplicationHelper
  def phone_number_link(text)
    sets_of_numbers = text.scan(/[0-9]+/)
    number = "+1-#{sets_of_numbers.join('-')}"
    link_to text, "tel:#{number}"
  end
end
~~~

Toss that in your app, and you can effortlessly make any phone number into a link.  The helper pulls out the numbers and pushes them back together in the standard "+1-xxx-xxx-xxxx" format.  ...which means you can use it with a variety of strings:

~~~ haml
I'd love to hear about your project.   Give me a call at
= phone_number_link("(626) 841-0708,")
and we can discuss your needs.
~~~

Cheers!
