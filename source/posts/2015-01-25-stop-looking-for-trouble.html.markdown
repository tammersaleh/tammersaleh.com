---
title: Stop Looking for Trouble
date: 2015-01-25 02:16 PST
description: An adage to help yourself avoid over-architecting.
---

One of the hardest judgement calls in programming is determining the balance between refactoring and progress.  Focusing on the quality of the codebase is an investment in its maintainability. Of course, when taken to the extreme, this can completely derail our progress on shipping functionality to our users.

So, how do we find the fulcrum that strikes the right balance?  In an agile development workflow, we rely upon the TDD cycle: red, green, refactor.  This produces a rhythm that maintains feature development without sacrificing quality.

However, some developers who are new to this workflow question whether it allows them to step back and look at ways of architecting the entire system in new and better ways.  One of the common misconceptions that leads to this doubt is in believing that the refactor step in "red, green, refactor" should only apply to the code you're currently writing. This creates a myopic behavior of only touching those bits of the codebase that are currently visible in the editor at this very moment.  Clearly that would be foolish -- refactorings often apply throughout an entire project.

But this isn't what the agile process encourages.  Instead, it dictate is that the refactoring *must* be driven by pain you're experiencing in the story you're currently working on.  

But why do we not spend that time specifically looking for refactoring outside the scope of the current story?  Surely cleaning up code is a good thing, no matter where or why?

### You can't predict the future.

Code changes constantly.  Continual refactoring, customer requirements, adoption of 3rd party libraries and more translates into entire continents of code disappearing overnight.  Investing time in cleaning up these undiscovered countries is often utterly wasted when those swaths of code are later removed wholesale.

What's more: These premature architectural changes solidify design choices.  Since we can't predict the future demands that will be placed upon our code, these new walls often have to be moved at great expense.

But most importantly, when we base our refactorings on tangible pain being felt at this moment, it's much more likely that we're actually avoiding future pain.  We can say with confidence: "That hurt.  Let's fix it to make sure it doesn't hurt again."

### Stop looking for trouble.

To help keep my attention on useful refactorings, I like to remind myself to **stop looking for trouble**.

If you find yourself finished with a story, and itching to find undiscovered places where code could be improved, **you're just looking for trouble**.

If you come up with clever ways of abstracting modules that aren't yet being used in other places, **you're just looking for trouble**.

If you start your greenfield application using microservices and a message buss, **you're just looking for trouble**.

If you say to your pair "Did you hear that noise down the alley?  Let's take a look!" then **you're just looking for trouble**.

### Trust.

There are two revelations that allowed me to stop looking for trouble:

1. If code is never touched, the interest on the debt it contains is almost zero.
1. My teammates are more than capable of tackling said code with a machete if and when they do finally touch that code.

This really all comes down to trust.  I realised that when I wanted to seek out strange and new places for technical debt, it was because I wasn't respecting my team.  I didn't trust them to clean up after themselves.

By basing your refactorings on the pain you're currently feeling, and by trusting that your team will do the same, you can be confident that you're making the product better, without spinning your wheels through over-engineering.

