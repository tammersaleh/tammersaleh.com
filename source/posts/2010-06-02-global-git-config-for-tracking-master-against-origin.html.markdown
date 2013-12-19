---
date: 2010-06-02 12:00 PDT
title: Global git config for tracking master against origin
description: A git configuration change that ensures your master branches are all configured to track origin.
---

Tired of doing a `git push origin master` when `git push` should be enough?  Google tells you to add the following to your project's `.git/config` file:

~~~
[branch "master"]
  remote = origin
  merge = refs/heads/master
~~~

While that works fine, it's a bit of a pain to do every time I start working on a new project.  Instead, you can set that globally like so:

~~~
git config --global branch.master.remote origin
git config --global branch.master.merge refs/heads/master
~~~

Now, running `git push` while in the `master` branch of your project will push the changes up to `origin` (which is most likely github).

While we're in there, let's tell git to always use `--rebase` when pulling into `master`, since we're a bit hater of the merge commits:

~~~
git config --global branch.master.rebase true
~~~

*Note:* I have this configured locally, and the only issue I've found is when I also have the changes in my `.git/config` file.  When I try to push, git complains thusly: `fatal: The current branch master is tracking multiple branches, refusing to push.`  It's a simple enough matter to remove the `master` configuration from the local `.git/config` file.
 
