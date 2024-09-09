---
layout: post
title: Azure Firewall Forced Tunnelling
subtitle: Azure Firewalls' lesser known feature and some interesting behaviour.
tags: [azure, firewall, networking, routing ]
author: Ed Berwick
---

I've recently come across a scenario where a customer wished to deploy an Azure environment with a small difference.

The infrstructure is aligned with the Azure Cloud Adoption framework and utilises the "traditional" network topology with network hub containing the gateway and firewall with workload spokes workloads peered with this hub.

 <https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/traditional-azure-networking-topology>

The difference in the customers scenario is that they wanted to separate their internet traffic from their intra spoke traffic and send internet bound traffic through a separate firewall (in this case a Check Point NVA, we'll come to that in another post).

There were a couple of reasons for this, the primary reason was a concern around the throughput capabilities of Azure Firewall Premium. The baseline throughput of the Azure Firewall Premium is 100 Gbps, however, with IDPS and SSL interception enabled this figure reduces to 10 Gbps.

All this considered the customer the dpeloyment was to 