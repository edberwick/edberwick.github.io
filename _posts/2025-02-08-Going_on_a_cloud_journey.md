---
layout: post
title: Going on a Cloud Journey?
subtitle: Make sure everyone is on the bus!
tags: [azure, cloud, opinion, journey, operating model, security ]
author: Ed Berwick
---

I recently wrote about how [We are all getting FinOps wrong](https://bezsez.co.uk/07-02-2025-We_are_all_getting_FinOps_Wrong/), and it got me thinking about the wider considerations of Cloud Adoption. Specifically some of my experiences through consulting, of the journeys organisations go through.

## Start the cloud bus

I [wrote previously](https://bezsez.co.uk/07-02-2025-We_are_all_getting_FinOps_Wrong/) about the "typical" cloud journey when it comes to FinOps. Specifically the steps that lead to a panicked implementation of FinOps.

The first thing to understand is that this isn't only a FinOps issue, this is an issue with a number of the supporting functions that are (or certainly should be) involved with Cloud adoption. The story usually plays out in a similar manner.

1. Customer goes all in on cloud, decides to build a build landing zone(s) for services to be migrated in to.
2. Customer performs 6 R's analysis of application estate, Forecast Costs and initiates migration, with majority lift and shift to IaaS.

Now this phase is pretty consistent, the next phase is where things change a little. The example below is typical when talking about FinOps

3. **Finance** department receive invoices from cloud provider and overspend is identified
4. IT Department starts looking at optimisation of migrated services.
5. IT Department realise there are some rocks that mean they still need a on-premises presence.
6. **Finance** and IT in loggerheads because costs have increased dramatically and there is no clear path forward.

If we replace Finance with Security we get...

3. **Security** department receive Security assessment result from third part and sever risk is identified
4. IT Department starts looking at security configuration of platform and migrated services.
5. IT Department apply security configuration and break migrated applications.
6. **Security** and IT in loggerheads because security risks has been missed and there is no clear path forward.

In both of these scenarios the problems are identified post the initial deployment and at a stage where there are workloads running on the environment and it is considered "live", "production" where changes cannot easily be made.

## Did you miss the bus or did it drove off without you

The proximate cause of these challenges is that not all of the supporting functions were on the cloud journey. Be it that they weren't invited, they weren't fully aware of the journey, or they don't have the skills, the outcome is the same bump or bollard in the road.

Often it's a combination of these, I've already described FinOps challenges in detail so I'll describe the other a classic example with security.  

### Security didn't get on

These days security should be a fundamental component of the Cloud Journey, however I've seen how security appear to be left behind. Sometimes Security are only bought onboard after a security assessment that finds there are some challenges with the security posture of the environment, sometimes it's a go live sign-off when security realise that there is shortly to be a service go-live and they have had no visibility of the build or process whatsoever. whatever the cause, delivering without security buy-in and sign-off becomes much more difficult, if not impossible because of the importance of the security function.

### Did engineering drive off

THe challenge is that most cloud deployments are driven by the engineering teams. As these teams deploy and manage workloads in the cloud, they also tend to be the teams who have most access to the service, they also by default, have a good working knowledge of the services available and are up to date on the new Services. You can't forget though, engineering teams have a focus on delivery and getting things done, they will know about the security features and capabilities, but often they drive the delivery of the cloud environment end to end and security are happy to let them.

These issues come to a head when security do become more involved, often they don't have cloud capabilities within their skill set. With no access and no knowledge of Cloud security they are on the back foot trying to play catchup with a engineering capability that's well ahead. This leads to frustration and friction on both sides reducing the agility of the engineering function.

## All aboard

In the same way that the FinOps framework helps to maximise the value of Cloud, a successful cloud journey requires the involvement of all of the Shared architecture pillars.

[![Shared architecture pillars](en-us/azure/cloud-adoption-framework/_images/ready/shared-principles.png){: .mx-auto.d-block :}](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/_images/ready/shared-principles.png)

Security is a key part of this and should be included from the very beginning, organisations can't bring them in during a later stage of the cloud journey. They need to be on the bus at the very beginning. All aboard!