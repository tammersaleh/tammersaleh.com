---
date: 2011-09-28 12:00 PDT
title: Useful MacVim Script
---

A wonderful little script I use on a daily basis is the MacVim shortcut below.

~~~ bash
#!/bin/bash

if [ $# == 0 ]; then
  mvim
else
  mvim --servername $(basename $(pwd)) \
       --remote-tab-silent "$@" 1>/dev/null 2>&1
fi
~~~

I have this saved as [v](https://github.com/tsaleh/dotfiles/blob/master/bin/v) in my `~/bin` directory, and here's how it works:

~~~
~/code/tsaleh/tammer-saleh$ v Gemfile
~~~

Opens Gemfile in a new macvim window:

![Image](vim_gemfile.jpg)

~~~
~/code/tsaleh/tammer-saleh$ v config.ru 
~~~

Opens config.ru in a tab in that same window, since we're still in the `tammer_saleh` directory:

![Image](vim_config_ru.jpg)

~~~
~/code/tsaleh/tammer-saleh$ cd ~/bin
~/bin$ v git-fml
~~~

Opens git-fml in a *new* macvim window, since we're in the `~/bin` directory:

![Image](vim_git_fml.jpg)

The magic is in the `pwd` call, which names the main window the same as your current directory.  The result is a natural flow of tabs being grouped by the project you're working on, and it works quite nicely.
