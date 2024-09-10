---
layout: post
title: Azure Firewall Forced Tunnelling
subtitle: Azure Firewalls' lesser known feature and some interesting behaviour.
tags: [azure, firewall, networking, routing ]
author: Ed Berwick
---

## The Problem

I've recently come across a scenario where a customer wished to deploy an Azure environment with a small difference.

Their infrstructure pattern was broadly aligned with the Azure Cloud Adoption framework utilising the "traditional" network topology with a network hub containing the gateway and firewall with workload spokes peered with this hub.

![Hub and Spoke](/assets/img/N_S_Traffic_Flow.png){: .mx-auto.d-block :}

 <https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/traditional-azure-networking-topology>

The difference in the customers scenario is that they wanted to separate their internet traffic from their intra spoke traffic and send internet bound traffic through a separate firewall (in this case a Check Point NVA, we'll come to that in another post).

![Hub Spoke and DMZ](/assets/img/Internet_Traffic_Flow.png){: .mx-auto.d-block :}

There were a couple of reasons for this, the primary reason was a concern around the throughput capabilities of Azure Firewall Premium. The baseline throughput of the Azure Firewall Premium is 100 Gbps, however, with IDPS and SSL interception enabled this figure reduces to 10 Gbps.

Whilst putting the design for this service together, I was trying to work out how best to approach. Initially I thought that I should simply use a UDR on the Azure Firewall Subnet to send traffic bound for the internet (route 0.0.0.0/0) to the 3rd Party NVA.

## The Solution

As I was pondering the deployment and re-reviewing the documentation I came across a configuration that is little discussed... Azure Firewall Forced Tunnelling. I'll let Microsoft make it clear why in the description of the feature.

_When you configure a new Azure Firewall, you can route all Internet-bound traffic to a designated next hop instead of going directly to the Internet. For example, you might have a default route advertised via BGP or using User Defined Route (UDR) to force traffic to an on-premises edge firewall or other network virtual appliance (NVA) to process network traffic before it's passed to the Internet. To support this configuration, you must create Azure Firewall with forced tunneling configuration enabled. This is a mandatory requirement to avoid service disruption._

Whilst I'd not used forced tunnel mode before, I assessed that this would be the most appropriate solution for the scenario and deployed Azure Firewall in Forced Tunnel mode.

Then  as Azure Firewall Forced Tunnel does not have a public IP Address to send traffic to the internet, an additional route was added to the Azure Firewall UDR to send all traffic boumd to the internet to the second firewall NVA.

![Routing](/assets/img/Internet_Routing.png){: .mx-auto.d-block :}

This was somewhat theoretical and whislt traffic was passing through Azure firewall correctly between all my locations, until the firewall NVA was deployed there was a lingering worry that I'd missed something. Fortunately once the NVA was deployed the routing worked as expected and sucessfully sent internet traffic to the second firewall NVA. Hooray (or not!) we had internal traffic flowing through Azure firewall and any internet bound traffic ws routed form the firewall to the NVA and then out to the internet.

## The Unexpected Issue

Azure firewall provides three types of rule, DNAT Rule, Network Rule and Application Rule

- **DNAT Rules**: These are routing rules that direct traffic from a public IP address to a private IP address.
- **Network rules**: These specify source addresses, protocols, destination ports, and destination addresses.
- **Application rules**: These define fully qualified domain names (FQDNs) that can be accessed from a subnet.

When deploying and configuring applications, it was identified that even with traffic flows allowed through Applicaiton rules traffic wasn't hitting the second firewall NVA as expected. Traffic was seen being processed by the Azure Firewall but the traffic was not getting to the NVA. Curiously traffic directed to Microsoft endpoint URLs that were being allowed through a Network Rule that used service tags was being passed to the NVA.

Armed with the genesis of a theory Azure Firewall configuration was updated to provide DNS Proxy which allows the use of FQDN's in Network rules. A network rule was configured to match the application rule and then application traffic started to hit the NVA and egress out to the internet.

{: .box-note}
**Note:** Network rules are much less fleixble than Application rules, you must enter the full FQDN, and wildcards are not allowed in a network rule, so "*.microsoft.com" becomes "www.microsoft.com"

This behaviour suggest that leveraging force tunnel mode prevents the Application rules from working. I suspect this is because internally Azure Firewall expects traffic matching Applicaiton rules to egress through it's own public IP, and it does not expect the traffic to pass through the firewall service. Definitely one to watch out for.
