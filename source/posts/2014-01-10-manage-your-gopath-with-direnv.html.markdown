---
title: Manage your GOPATH with direnv
date: 2014-01-10 11:19 PST
description: A simple way of using direnv to manage your GOPATH environment variable when working with multiple golang projects.
---

One of the most contentious aspects of golang is the simplistic approach to managing your dependencies and workspace.  Go relies on the `$GOPATH` environment variable, which should point to the root directory that contains *all* of your golang software.  The rumour is that developers at Google have a *single* Perforce repository that contains all of their projects.  

The fact of life outside of Google is that most developers either prefer or are forced to keep their projects separated.  So how do we make that work nicely with having a single `$GOPATH` variable?

The most common solution I've seen in the wild is to either wrap the `go` command or add a separate script that simply sets `$GOPATH` to the current working directory.  This can work, but is fairly manual, and can get confusing if you're in a subdirectory of your project.

Instead, I'd like to introduce you to a wonderfully simple tool that I recently ran across:  [Direnv](http://direnv.net/).

Direnv's mission is to "unclutter your .profile," which it delivers on.  More accurately...

> direnv is a shell extension that loads different environment variables depending on your path.
> 
> Instead of putting every environment variable in your `~/.profile`, have directory-specific `.envrc` files for your `AWSACCESSKEY`, `LIBRARY_PATH` or other environment variables.
> 
> It does some of the job of rvm, rbenv or virtualenv but in a language-agnostic way.

Here's how you can use direnv as the magic bullet for managing your `$GOPATH`.

### Installing

```
$ brew update
$ brew install direnv
$ echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
```

### Configuring

Now, in each of your go projects, create a `.envrc` file:

```
~/some/go/project $ echo 'export GOPATH=$(PWD)' > .envrc
```

### Security!

The first time you `cd` into a directory with a `.envrc` file, it will refuse to load the file.  This is to protect you, since the contents of the `.envrc` will be executed by your shell, and they might come from untrusted sources.  Simply run `direnv allow .envrc`, and it will trust that file until the next time it changes.

### Using

From now on, your `$GOPATH` will be correctly set if and only if you're somewhere inside that project.

```
 $ cd some/go/project/
direnv: loading .envrc
direnv export: +GOPATH

~/some/go/project $ echo $GOPATH
/Users/tsaleh/some/go/project

~/some/go/project $ cat .envrc
export GOPATH=$(PWD)

~/some/go/project $ cd ~/
direnv: unloading
direnv export: -GOPATH

~ $ echo $GOPATH
```

### So easy it's built in!

In fact, this is so useful, it's actually [built into direnv](http://direnv.net/stdlib.html)!  Instead of setting the variable manually in your `.envrc` file, you can use the `layout` function that direnv provides:

```
~/some/go/project $ echo 'layout go' > .envrc
```

