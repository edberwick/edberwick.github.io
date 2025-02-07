---
layout: post
title: We're all getting FinOps wrong
subtitle: Fin Ops is just about reduction of cloud spend right? RIGHT??
tags: [azure, finops, opinion, process, foundation ]
author: Ed Berwick
---

## Introduction

Yesterday I sat down with a colleague who has been at my organisation for a similar length of time our paths haven't crossed. This is probably because part of my role as an Azure Solution Architect is to drive cloud (Azure) consumption and his, as a FinOps guy is to stop me doing that, or so I thought...

In actuality I came out of our conversation converted, or at the very least I had a much better appreciation of the term FinOps, what's below is a very high level 1 day in appreciation but I think it's an appreciation that people need to understand.

## We've been getting it wrong

The Cloud Migration cycle that I've seen with customers and in the industry in general is broadly similar to the below:

1. Customer goes all in on cloud, decides to build a build landing zone(s) for services to be migrated in to.
2. Customer performs 6 R's analysis of application estate, **Forecasts** Costs and initiates migration, with majority lift and shift to IaaS in aforementioned cloud landing zones without **Architecting for Cloud**.
3. Finance department receive invoices from cloud provider and point out to IT Department that **Forecasts** and actuals **Reporting & Analytics** are in variance.
4. IT Department starts looking at **Workload Optimisation** of migrated services and accelerates (or halts) the migration in to cloud of remainder.
5. IT Department realise there are some rocks that mean they still need a on-premises presence.
6. Finance and IT in loggerheads because costs have increased dramatically and there is no clear path forward.

The above example, is when many organisations first start thinking about FinOps.  IT Departments project a cost, they build, Finance tells them they are  overspending and must keep to the agreed cost, IT Department then makes changes in an attempt to keep cost down. Some organisations start performing **Invoicing & Chargeback** internally. But this is generally as far as it goes, with cost and cost reduction often the key metrics used when thinking about FinOps

## New Challenges

There are new challenges as well, in the past we had very well defined projects and we had absolute costs, the example my colleague provided was one that was ultimately very familiar to me. We want to build a data centre, we identify the business value or need, we form a project, run an RFP for Data Centre space, get quotes from our suppliers for hardware and software, and we run this through finance, and then the company governance structure who then hopefully provide a green light. These are fixed costs that stakeholders at a senior level sign off and can be budgeted for.

Today we don't really do this, and certainly not at the level. These days it takes an engineer less than 10 lines of code and about 10 minutes to create a resource that might cost more in a month than a data centre might cost in its lifetime.

The ability to spend a substantial amount of an organisations money has been devolved from the Executive and Management level to the Engineering level and without appropriate process and control in place could lead you towards severe problems, we're probably not talking about Nick Leeson and Barings Bank levels, but maybe?

## Let start again

Will FinOps solve all of these problems? No. Will it help identify and manage the value of cloud? Yes!

### What is FinOps?

_FinOps is an operational framework and cultural practice which maximizes the business value of cloud, enables timely data-driven decision making, and creates financial accountability through collaboration between engineering, finance, and business teams._

[What is FinOps?](https://www.finops.org/introduction/what-is-finops/)

Ahh so it's a framework? Yes, and it's a framework that expands the capabilities I've highlighted above (the bold words) and brings them together to drive a cultural practice to maximise the business value of cloud.

![FinOps Framework](https://www.finops.org/wp-content/uploads/2024/03/FinOps-Framework-Poster-v4.pdf){: .mx-auto.d-block :}

### New Capabilities

Whilst my colleague was guiding me through the framework, it became very clear to me that the dimensions that we talk about when it comes to cloud costs are often wrong. We talk around the absolute cost of compute, the absolute cost of storage without providing the business value of Cloud services, what are the returns on investment?

We need to start thinking about how to **Quantify Business Value** by including **Unit Economics** in our calculations, if for example you have a service that for every £10 you spend on compute you actually increase revenue by £100 perhaps there is less need to focus on this service that the service that provides a 10:5 ratio of input to revenue.

Remember the Engineer who might cause your organisation go to the way of Barings Bank, well **Anomaly Detection** capabilities within the FinOps framework should help to reduce the risk of this occurring.

## Summary Conclusion

I know many of these capabilities are often viewed and considered in isolation, Microsoft Azure for example, recommends enabling cost alerting to help reduce unexpected cloud cost rather than being part of a wider framework and cultural practice that is ingrained within the organisation to really maximise the business value of cloud.

I would absolutely recommend visiting the [FinOps foundation site](https://www.finops.org/) and taking their free introduction training to help broaden your understanding of FinOps and it concepts to really maximise the value of Cloud.
