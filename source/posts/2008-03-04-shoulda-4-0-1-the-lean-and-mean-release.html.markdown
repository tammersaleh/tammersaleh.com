---
date: 2008-03-04 12:00 PDT
title: Shoulda 4.0.1 - the lean and mean release
---

![Image](baby.jpg medium)
{.img_left}

Shoulda is a great tool for cleaning up your tests, but there was always some dirt under the hood that was keeping me up at night.  I don't want to just [move complexity around](http://www.klankboomklang.com/2007/10/26/class-methods-part-ii-annotations/) - I want to remove it entirely.

A recent change in edge rails forced me to get off my butt and do that.

So everyone give a warm hello to the latest [Shoulda gem](http://rubyforge.org/projects/shoulda).  It now uses a Context class in the backend, prints out `should_eventually` tests in a clear way, names the bare shouldas nicely, and fixes a few small bugs.

I also took the opportunity to fix some of the outstanding issues in the [shoulda rails plugin](http://thoughtbot.com/projects/shoulda) (with a lot of great help from the community).

So grab the latest plugin and have some fun.  Also, please let me know if you find any bugs or issues.
