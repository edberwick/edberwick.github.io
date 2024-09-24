---
layout: post
title: DNS, It's always DNS
subtitle: How Azure Migrate is a great tool but doesn't care about any of your existing private DNS config. 
tags: [azure, dns, networking, migrate, privatelink, privateendpoint, privatedns, routing ]
author: Ed Berwick
---

## Introduction

This post has a slightly different tack to my previous post. In this post i want to describe a frustration I have with what is essentially a very good tool. I know there are multiple ways around the problem, but my frustration comes from the fact the solutions are manual and require a bit of thought to ensure ongoing success. What is fortunate is the resolutions for the issues are mainly a once and done, but might require you to grant higher levels of privilege than you might want to allow remediation of the issue.

## Azure Migrate

Azure Migrate is a great tool, there, I said it. It is one of those nice simple tools that just does what it says on the tin, especially when it comes to migrating workloads from a VMWare source. With the Azure Migrate Appliance, agentless migration is pretty simple and painless. As long as the pre-requisites of permissions, connectivity and VMDDK are all in place, then the process of migration is pretty smooth. It'll even turn off the source VM for you.

{: .box-note}
**Note:** On the subject of VMDDK, if you're migrating from an older version of VSphere you should try and use the closest version of the VMDDK that you can. VMDDK version 8 does not seem to play nicely with VSPhere 6.0 for example.

## Connectivity

As mentioned connectivity is important, there are connections required between the appliance and VMWare as well as between the appliance and the Azure platform. There are two types of traffic that flow between Azure Migrate and the Azure platform.

- Control Traffic
- Replication Traffic

By default both of these traffic flows will egress by the organisations internet gateway and traverse the public internet to Azure migrate public endpoints.

![Azure Migrate - Internet](/assets/img/Azure_Migrate_Internet.png){: .mx-auto.d-block :}{: height="600" }

To provide additional security you can also deploy Azure Migrate with (Semi-)Private connectivity using Private Endpoints.

![Azure Migrate - Private](/assets/img/Azure_Migrate_Private.png){: .mx-auto.d-block :}{: height="600" }

Control Traffic will still traverse the internet, however replication traffic will use private endpoints, herein lies a problem.

## Private DNS

Private endpoints are interfaces for services that exist in your private network in Azure, private endpoints will inherit the same DNS name as the public endpoint. To ensure that intranet resources resolve the correct address, private DNS zones are deployed to provide intranet resolution of services to these private endpoints.

Typically organisations will setup their own, centralised Private DNS zones to ensure a single source of DNS truth and ensure that these DNS zones are appropriately managed and controlled, no one wants rogue DNS entries.

## Azure Migrate Private Endpoint Setup

When setting up an Azure Migrate project and the Private Endpoint option is chosen

![Azure Migrate - Configure Endpoint](/assets/img/Azure_Migrate_Config.png){: .mx-auto.d-block :}

The project and appliance creation process creates several private endpoints, which is great (yes I did name my appliance dave).

![Azure Migrate - Private Endpoints](/assets/img/Azure_Migrate_Endpoints.png){: .mx-auto.d-block :}

As well as several private DNS Zones which is not so great.

![Azure Migrate - Private DNS Zones](/assets/img/Azure_Migrate_Endpoints.png){: .mx-auto.d-block :}

Whilst this behaviour is okay(ish) when you have a greenfield environment that does not have any existing private DNS zones, if you have an environment that has existing cloud native workloads or you used the Microsoft [Platform landing zone accelerator](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/#platform-landing-zone-accelerator) (and why wouldn't you?), then you've now got another bunch of DNS Zones that are outside of your carefully governed Private DNS solution.

Depending on your organisations Operating Model you may have a scenario where the team who manage DNS are not the same team who will be configuring and managing Azure Migrate, you can look to delegate privileges through PAM and grant privileges only to specific DNS zones, but it doesn't feel that elegant.

This also adds a layer of complexity to the configuration and troubleshooting in the future, but then I guess that's why we're still gainfully employed.

As I said it's always DNS.
