---
date: 2013-09-24 12:00 PDT
title: "AWS: Consolidated Billing, Reserved Instances and Availability Zones"
---

If you're tasked with managing a large installation on AWS, and you expect to use consolidated billing, then your life will be getting more complicated than you might expect.  In fact, if you're already managing such an installation, then your life might already be more complicated than you previously thought it was.  Confused?  Get used to it.

AWS gives us two highly useful tools for managing large installations:

### Reserved Instances

By purchasing a Reserved Instance (from now on, referred to as RIs) for one or three years for a specific instance type in a specific Availability Zone (AZ) *name* (more on that later), you can reduce your amortized hourly rate by [between 39% and 73%](http://mikekhristo.com/ec2-ondemand-vs-reserved-instance-savings-calculator/).  That's some massive savings.

### Consolidated Billing

![Image](consolidated_billing/source.png)

Consolidated Billing allows you to roll up the bills for multiple accounts into a single master account.  This not only makes the lives of your accounting staff easier, but it also allows you to benefit from some of the bulk discounts offered by AWS.

![Image](az_mismatch/source.png)
{: .img_right}

If you're managing a large installation and your not using RIs, you're definitely doing it wrong.  If you're not using Consolidated Billing, then you're only *likely* doing it wrong.

However, all is not roses.  There are three details that work together to make your life complicated.

#### Obfuscation

AZs are named differently between accounts. This is likely done to avoid overloading a single AZ as everyone stampedes to provision their instances in the first choice.  This also applies to the consolidated billing master and sub-accounts.

#### Reserved Instance Placement

I mentioned earlier that RIs are tied to AZ **name**, not the actual building.  This is conceptually silly, but likely just a consequence of needing to identify the AZ while obfuscating the actual location.

#### Dead Availability Zone

One of the AZs in US East (the most popular region, by far) is effectively out of commission. You can see this by calling the [describe AZs api endpoint](http://docs.aws.amazon.com/AWSEC2/latest/CommandLineReference/ApiReference-cmd-DescribeReservedInstancesOfferings.html), which will return only four out of the five AZs you'd expect to see.  Any attempts to provision in that AZ will consistently fail.  Of course, this AZ is *named* differently for everyone.

![Image](azs/large.png)

#### The adequate storm?

Because of all of this, RIs purchased in the consolidated billing account aren't nearly as useful as you might have expected.

While you do gain the reduced price, these RIs aren't actually "reserved".  There isn't a dormant VM sitting idle, waiting for you to provision it.  This means you still get the normal number of out of capacity errors.

You can't hard-code AZ names in your deploy scripts if those scripts are shared across sub-accounts -- for one out of five of those accounts, the named AZ will be the dead one.  You must use the [describe AZs api endpoint](http://docs.aws.amazon.com/AWSEC2/latest/CommandLineReference/ApiReference-cmd-DescribeReservedInstancesOfferings.html) in your scripts to determine AZ names dynamically.

You also lose some granularity in how you target your RIs. If you know that every sub-account will provision a `cr1.8xlarge` in `US-East-a1` XXX

1. Bob's dead AZ may be 

What you can do about it:

* Law of scale may save you if all of your accounts are roughly identical.  The bigger you get, the more vague you can be about the word "roughly".
* Now able to move RIs between AZs.
* Buy RIs in each sub-account.


