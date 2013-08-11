---
date: 2007-11-08 12:00 PDT
title: ! 'Book Review: Trouble-shooting Ruby Processes by Philippe Hanrigou'
---

Addison-Wesley has been releasing a number of Ruby and Rails books under the editorship of Obie Fernandez.  I got my hands on "[Troubleshooting Ruby Processes](http://www.informit.com/store/product.aspx?isbn=0321544684&rl=1)" by [Philippe Hanrigou](http://www.informit.com/authors/author_bio.aspx?ISBN=0321544684), and I have to say that I was very impressed with the material presented.

![Image](troubleshooting-ruby-processes/original.jpg)
{:.img_left}

To put my views in perspective:  While I have only spent the last year as a professional Rails programmer, I spent around 6 years before that as a UNIX administrator.  I've worked with networks of between 40 and 400 machines - so my skills may be a bit rusty, but I still know the UNIX side of things pretty well.  That being said, I still had a few things to learn from this 56 page PDF.  

"Troubleshooting Ruby Processes" does a wonderful job of explaining the details of how to use tools like `lsof`, `strace` and `gdb`, while maintaining a good focus on applying them to ruby and mongrel processes.  It also does a good job of ramping the reader through more and more involved methods of testing, and of providing practical explanations of when you would and wouldn't want to use each one.

If I were to make one change to the book, it would be to spend some time explaining the [DTrace](http://en.wikipedia.org/wiki/Dtrace) system in detail.  It mentions DTrace, and explains that it's too big of a topic to cover, but I still would have liked to see a more involved introduction.  A quick explanation of the syntax with a couple of examples showing what you can do with the tool would have been great.  DTrace was released with Solaris 10, is part of OS X 10.5, and is being ported to FreeBSD - all of which means it will soon be a fairly ubiquitous tool for production troubleshooting.

If you work on production ruby applications, then there's no reason not to spend the $14 for this PDF.  You can purchase "Troubleshooting Ruby Processes" [here](http://www.informit.com/store/product.aspx?isbn=0321544684&rl=1), and you can find the rest of the Addison-Wesley offerings [here](http://www.informit.com/ruby).
