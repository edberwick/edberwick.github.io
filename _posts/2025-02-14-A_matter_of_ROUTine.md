---
layout: post
title: A matter of ROUTinE
subtitle: Don't let good practice catch you out
tags: [azure, firewall, asymmetric, networking, routing ]
author: Ed Berwick
---

## Good practice hub and spoke

As many people know, the routine way to secure an Azure landing zone is to use an Azure Firewall or NVA in the hub. This is specifically referred to as the [Traditional Azure networking topology](https://learn.microsoft.com/en-gb/azure/cloud-adoption-framework/ready/azure-best-practices/traditional-azure-networking-topology), the choice of firewall is yours but I do have a preference for the Azure Firewall due to the fact in most scenarios it simply works.

As you will have seen in previous blog posts [here](https://bezsez.co.uk/08-09-2024-AzureFirewall_ForcedTunnel/), I recently deployed Azure firewall in forced tunnel mode, which required the use of FQDN's in the firewall Network Rules. To allow FQDN's to be used in Network rules you must enable DNS proxy for your Azure Firewall [https://learn.microsoft.com/en-us/azure/firewall/fqdn-filtering-network-rules](https://learn.microsoft.com/en-us/azure/firewall/fqdn-filtering-network-rules).

As we were concerned about the resolution Internal Private IP's we ensured that we configured the DNS servers for the firewall as the Domain Controllers that had been built in the Identity Landing Zone spoke.

{: .box-note}
**Note:** Why didn't you use private resolver etc.. I hear you cry! Well, mainly because we were integrating with an existing Private DNS configuration which meant the appetite for change an potential disruption was low.

Now to ensure that traffic was routed correctly to the Firewall in the hub UDR's were deployed, the UDR's were configured to route traffic to the firewall in the hub and would look broadly like this

| Name | Address prefix | Next hop type | Next hop IP address |
| :------ |:--- | :--- | :--- |
| Everywhere | 0.0.0.0/0 | Virtual Appliance | 10.0.0.1.4 |
| To Hub | 10.0.0.0/22 | Virtual Appliance | 10.0.0.1.4 |

This ensures that all of the traffic passes through the firewall, even if it's going hub network (though you don't have anything deployed in that network other than a Gateway and a firewall do you).

This means the environment looks a bit like this...

![Hub and Spoke UDRs](/assets/img/Hub_Spoke_Routing_UDR.png){: .mx-auto.d-block :}{: height="600" }

## Going around in circles

Things seemed to be working well, but one of the team noticed some weird traffic showing up in the firewall logs. The traffic was coming from the Domain Controllers (DNS servers) and the source was 53 UDP, with the target being a high port.

![Deny 53 from DC](/assets/img/Firewall_Deny.jpeg){: .mx-auto.d-block :}

This didn't sit right with me and I did a bit of thinking, as I said it didn't seem to be causing any noticeable issues, so at best it was a red herring when filtering for denied traffic, at worst it was having a background impact on the performance and behaviour of the firewall.

As is usual with these things, the answer hit me when falling asleep, it was the DNS response being routed to the the firewalls private interface rather than the actual source of the traffic (one of the backend firewall resources). Why was this, well this was happening because the route table was telling it to go that way!

## Route one

Because the traffic was trying to respond to an IP in the hub, it was respecting the UDR and trying to hit the firewall on it's private IP Address, fine in most situations but not really ideal when trying to return a DNS query.

The fix was pretty simple, remove the route to the hub in the Identity spoke so that it looked like this

| Name | Address prefix | Next hop type | Next hop IP address |
| :------ |:--- | :--- | :--- |
| Everywhere | 0.0.0.0/0 | Virtual Appliance | 10.0.0.1.4 |

![Hub and Spoke updated UDRs](/assets/img/Hub_Spoke_Routing_Fixed_UDR.png){: .mx-auto.d-block :}{: height="600" }

This stopped the traffic from being routed in a circular manner, and allowed (presumably) the query to complete successfully.

As I say I've not noticed a specific issue, however it's always nice to solve an unexplained behaviour like this, and I'm sure that the query completing correctly is the behaviour we want to see.
