#!/bin/bash
# Adds suggested Title / Subtitle / Tags to each backlog issue's body,
# on top of the existing Pillar + Wireframe content.
# Looks up each issue by exact title, so numbering doesn't matter.

update_issue() {
  local title="$1"
  local body="$2"
  local num
  num=$(gh issue list --search "\"$title\" in:title" --state all --json number --jq '.[0].number')
  if [ -z "$num" ]; then
    echo "!! Could not find an issue titled: $title"
    return
  fi
  gh issue edit "$num" --body "$body"
  echo "Updated #$num - $title"
}

update_issue "Landing zones as an ongoing negotiation, not a one-off design" "**Pillar:** Azure architecture

Wireframe:
- Landing zones are usually pitched and funded as a one-off design/build project
- Reality: platform and workload teams have genuinely different, evolving needs - policy relaxations, new subscription vending requests, exceptions
- Walk through a real example of a request that forced the landing zone model to change post-go-live
- Framework: what should be genuinely fixed (guardrails) vs what should be a living negotiation (policy exceptions, subscription types)
- Closing take: budget and resource the landing zone as an ongoing platform function, not a project with an end date

---
**Suggested title:** Landing Zones Are Never Finished
**Suggested subtitle:** Why your landing zone should be treated as an ongoing negotiation, not a one-off design
**Suggested tags:** azure, landing-zones, platform, governance"

update_issue "When to deviate from the Microsoft reference architecture" "**Pillar:** Azure architecture

Wireframe:
- The reference architecture is a strong default, not a mandate
- Real reasons to deviate: regulatory requirement, existing investment, genuine scale/performance need
- Bad reasons to deviate: familiarity, fear, 'we've always done it this way' (ties to the customisation/change theme)
- A framework for justifying a deviation to a review board or client - documenting the trade-off, not just the decision
- A real example of a deviation that was justified, and one that wasn't

---
**Suggested title:** When to Break the Reference Architecture
**Suggested subtitle:** The Microsoft reference architecture is a strong default, not a mandate - here's how to know when deviating is the right call
**Suggested tags:** azure, architecture, landing-zones, governance"

update_issue "An asymmetric-routing gotcha from a recent hub-and-spoke build" "**Pillar:** Azure architecture

Wireframe:
- Set the scene: a hub-and-spoke topology that looked textbook-correct
- The specific symptom that surfaced - inconsistent or dropped traffic, hard to reproduce
- The diagnosis process - what was checked first, the red herrings, what actually found it (UDRs, NVA routing asymmetry, NAT)
- The fix
- The broader lesson: how to test for this class of problem before it hits production

---
**Suggested title:** Another Asymmetric Routing Story
**Suggested subtitle:** A fresh hub-and-spoke networking gotcha, how it was diagnosed, and how it was fixed
**Suggested tags:** azure, networking, firewall, hub-and-spoke"

update_issue "Why cost anomaly alerts are useless without an owner attached" "**Pillar:** FinOps

Wireframe:
- The common setup: cost anomaly detection turned on, alert fires, goes to a shared inbox nobody checks
- Why this happens organisationally - cost ownership is diffuse, nobody's job description says 'investigate cost alerts'
- What 'useful' actually looks like - alert routed to a named owner, expected response SLA, tied to the business owner of that subscription or resource group
- A short framework for setting this up properly
- A real example of an anomaly that would have been caught early with proper ownership

---
**Suggested title:** Cost Alerts Nobody Owns Are Just Noise
**Suggested subtitle:** Why a cost anomaly alert is worthless until it has a named owner behind it
**Suggested tags:** finops, cost-management, governance"

update_issue "FOCUS 1.1 in practice: what changed and is it worth adopting now" "**Pillar:** FinOps

Wireframe:
- Quick primer on what FOCUS is and why it exists - cross-cloud cost data standardisation
- What's actually new or different in 1.1 versus prior versions
- The migration effort required from existing Cost Management exports
- Is it worth adopting now, or wait - a genuine cost/benefit call, not hype
- Where to start if you decide to move

---
**Suggested title:** FOCUS 1.1: What Changed, and Is It Worth Adopting Now
**Suggested subtitle:** A practical look at the FOCUS 1.1 spec update and whether it's worth migrating your cost exports today
**Suggested tags:** finops, cost-management, focus"

update_issue "A cost decision that looked wrong on the invoice but was right for the business" "**Pillar:** FinOps

Wireframe:
- The setup: a specific decision that, viewed purely on the invoice, looked like overspend
- The business context that changed the calculus - risk avoidance, speed to market, team capacity
- Why FinOps needs to resist becoming pure cost minimisation
- A framework for evaluating 'is this actually wasteful, or does it just look wasteful'
- Closing take: FinOps is about value, and value isn't always the cheapest line item

---
**Suggested title:** The Cost Decision That Looked Wrong, But Wasn't
**Suggested subtitle:** A real example of a decision that looked like overspend on the invoice, but was right for the business
**Suggested tags:** finops, cost-management, leadership"

update_issue "The operating-model conversation that should happen before the migration plan" "**Pillar:** Cloud adoption

Wireframe:
- The common pattern: the migration plan gets built and approved before anyone asks 'who runs this once it's live'
- What goes wrong when operating model is an afterthought - unclear ownership, support gaps, tooling mismatches
- A short framework for the operating-model questions that should be answered in week one, not month six
- A real example of a migration that succeeded technically but struggled operationally because of this gap

---
**Suggested title:** Operating Model Before Migration Plan
**Suggested subtitle:** Why the operating-model conversation needs to happen before the migration plan is built, not after
**Suggested tags:** cloud-adoption, operating-model, migration"

update_issue "What cloud maturity actually looks like 18 months post-migration" "**Pillar:** Cloud adoption

Wireframe:
- The vendor pitch at the start of a migration vs the reality 18 months later
- Honest markers of maturity - not 'how many workloads migrated' but incident response time, cost visibility, team confidence, governance drift
- A grounded, anonymised case study of where an organisation actually landed
- What 'good' realistically looks like at 18 months, versus the unrealistic bar often set at kickoff

---
**Suggested title:** Cloud Maturity, 18 Months In
**Suggested subtitle:** What cloud maturity genuinely looks like a year and a half after migration, versus what the vendor promised at the start
**Suggested tags:** cloud-adoption, migration, operating-model"

update_issue "A retrospective on a transformation programme that stalled" "**Pillar:** Cloud adoption

Wireframe:
- Set the scene: the programme, the ambition, where it stalled
- Root causes - technical, organisational, or both (specific but anonymised)
- What would have needed to be true for it to succeed
- What restarted it, if it did, or what the current state actually is
- The broader lesson for anyone starting a similar programme

---
**Suggested title:** A Transformation Programme That Stalled
**Suggested subtitle:** An honest retrospective on why a transformation programme lost momentum, and what would have needed to be true to succeed
**Suggested tags:** cloud-adoption, transformation, leadership"

update_issue "Repeatable platforms vs bespoke builds in regulated environments" "**Pillar:** Platform & operations

Wireframe:
- The tension - platform engineering wants standard, reusable patterns; regulated environments often demand case-by-case justification
- Where the line genuinely needs to sit - always standardise security baselines vs where bespoke is legitimate
- A framework for evaluating a bespoke request - is it regulation, or preference dressed up as regulation
- A real example from delivery

---
**Suggested title:** Repeatable Platforms vs Bespoke Builds
**Suggested subtitle:** Where the line genuinely sits between standardised platform patterns and the bespoke exceptions regulated environments require
**Suggested tags:** platform-engineering, regulated-industries, governance"

update_issue "A walkthrough of an Azure Verified Module and what it saved" "**Pillar:** Platform & operations

Wireframe:
- Pick a specific AVM used in a real build
- Before/after - what it would have taken to write and test this from scratch vs adopting the module
- Any friction encountered adopting it - versioning, customisation limits
- The actual time or effort saved, with real numbers if possible
- When AVMs are, and aren't, the right call

---
**Suggested title:** What an Azure Verified Module Actually Saved Us
**Suggested subtitle:** A concrete walkthrough of adopting an AVM in a real build, and the time it saved versus writing it from scratch
**Suggested tags:** azure, iac, platform-engineering, avm"

update_issue "Managed services: the SLA conversation nobody wants to have" "**Pillar:** Platform & operations

Wireframe:
- Why this conversation gets avoided - it feels awkward and adversarial, easier to assume good faith
- What happens when it's skipped - a real incident where unclear SLA expectations caused a problem
- What a good SLA conversation actually covers - response times, escalation, ownership boundaries, what's explicitly out of scope
- A framework for having this conversation early, framed collaboratively rather than adversarially

---
**Suggested title:** The SLA Conversation Nobody Wants to Have
**Suggested subtitle:** Why the SLA conversation needs to happen early in a managed services relationship, not after something breaks
**Suggested tags:** managed-services, operations, sla"

update_issue "What changes about decision-making once you're managing the team making them" "**Pillar:** Technology leadership

Wireframe:
- The shift from personally making the right call to enabling someone else to make it
- A specific example of a decision you'd have made differently yourself, but let stand because it was right for the team's growth
- The skills this actually requires - asking better questions, tolerating a different route to the same outcome
- What doesn't change - technical judgement is still needed, just applied differently

---
**Suggested title:** Decisions Change When You're Managing the People Making Them
**Suggested subtitle:** What actually changes about technical decision-making once you move from making the call yourself to enabling your team to make it
**Suggested tags:** leadership, technology-leadership, management"

update_issue "A time I overruled my own architecture instinct for an org reason" "**Pillar:** Technology leadership

Wireframe:
- Set the scene - the technical call your instinct wanted to make
- The organisational reason it got overruled - political, budget, timeline, team capability
- Honest reflection - was it the right call in hindsight, or not
- What this teaches about the gap between 'technically correct' and 'organisationally viable'

---
**Suggested title:** The Time I Overruled My Own Architecture Instinct
**Suggested subtitle:** A technical call my instinct wanted to make, and the organisational reason it got overruled - was it the right call?
**Suggested tags:** leadership, architecture, decision-making"

update_issue "Building psychological safety on a platform team without losing pace" "**Pillar:** Technology leadership

Wireframe:
- The false trade-off often assumed between psychological safety and delivery speed
- What actually erodes psychological safety on a technical team - blame culture after incidents, dismissing junior input, unclear ownership
- Concrete practices that build both safety and pace - blameless postmortems, clear decision rights, room to disagree before a decision locks in
- A real example from your own team

---
**Suggested title:** Psychological Safety Without Losing Pace
**Suggested subtitle:** Why psychological safety and delivery speed aren't actually a trade-off on a platform team
**Suggested tags:** leadership, platform-engineering, team-culture"

update_issue "You're not special: the cost of customising instead of adopting" "**Pillar:** Cloud adoption

Wireframe:
- Open with the Birmingham City Council Oracle figures (GBP19.9m budgeted, over GBP216m and counting) as the anchor example
- Pair with the first-hand Michael Page CRM customisation story
- Core thesis - most organisations aren't special enough to justify the cost and risk of heavy customisation
- The psychological pattern - fear of change dressed up as a business requirement
- A framework for challenging a customisation request - is this a genuine business differentiator, or discomfort with change
- Closing take

Source: https://www.linkedin.com/posts/giles-lancaster_total-cost-of-birmingham-citys-oracle-system-activity-7504099020114620416-NMi9

---
**Suggested title:** You're Not Special
**Suggested subtitle:** What Birmingham City Council's GBP216m Oracle rebuild - and a CRM I once watched get customised into oblivion - teach us about the real cost of resisting change
**Suggested tags:** cloud-adoption, leadership, change-management"

update_issue "Naming conventions: why is it so hard" "**Pillar:** Azure architecture

Wireframe:
- The paradox - naming standards look trivial on paper (CAF has a whole doc) but almost every org gets stuck on them
- The real cause isn't technical: it's competing stakeholders (security, network, app teams) plus pre-existing naming debt from legacy systems
- Case for 'good enough and consistently enforced' over a perfect taxonomy nobody follows
- A practical framework: where rigidity actually matters (subscriptions, resource groups) vs where flexibility is safe (individual resource names)
- Closing take: naming conventions fail because they're treated as a technical decision when they're really an organisational agreement problem

---
**Suggested title:** Naming Conventions: Why Is It So Hard
**Suggested subtitle:** Naming standards look trivial on paper - here's why almost every organisation gets stuck on them anyway
**Suggested tags:** azure, governance, landing-zones"

update_issue "AD Sites/Services: don't use a supernet, it doesn't work" "**Pillar:** Azure architecture

Wireframe:
- The temptation - using a supernet to cover multiple subnets in one AD Site to simplify site definitions
- Why it breaks - AD site selection and subnet-to-site mapping behaviour, DC locator logic, replication topology issues that emerge
- A real symptom walkthrough - clients authenticating to the wrong DC, slow logons, confused replication topology
- The fix - explicit subnet objects, no overlapping supernets
- Lesson - shortcuts in legacy AD design still bite you even in a hybrid/Azure world

---
**Suggested title:** Don't Use a Supernet for AD Sites and Services
**Suggested subtitle:** Why using a supernet to simplify Active Directory site definitions breaks DC locator logic and replication topology
**Suggested tags:** active-directory, networking, identity"

update_issue "Private DNS is a challenge: how does it work during failover" "**Pillar:** Azure architecture

Wireframe:
- Quick primer on Azure Private DNS zone linking and conditional forwarding
- What 'failover' actually means here - region failover, resolution path during an outage, the single-point-of-failure risk in centralised DNS resolver VMs or firewall DNS proxying
- Walk through a specific failure scenario - what breaks, what doesn't, and why
- Design patterns for resilience - redundant resolvers, avoiding single-VNet dependency, where Azure DNS Private Resolver fits
- Takeaway - DNS is invisible right up until it's the reason everything is down

---
**Suggested title:** Private DNS During Failover: How Does It Actually Work
**Suggested subtitle:** A walkthrough of what happens to Azure Private DNS resolution during a regional failover, and how to design around it
**Suggested tags:** azure, networking, dns, resilience"

update_issue "Microsoft accelerators: why not use the landing zone accelerator" "**Pillar:** Azure architecture

Wireframe:
- The pitch for ALZ - speed, baked-in best practice, Microsoft-maintained
- Where it genuinely doesn't fit - brownfield environments, existing regulated governance, tooling mismatches (Terraform vs Bicep), team ownership concerns
- The harder question - is the reason for avoiding it real architectural judgement, or fear of losing control? (nice tie-in to the 'You're not special' piece)
- A balanced verdict - when to adopt as-is, when to fork it, when to walk away entirely

---
**Suggested title:** Why Not Just Use the Landing Zone Accelerator
**Suggested subtitle:** The Azure Landing Zone accelerator is a strong starting point - here's when it genuinely doesn't fit, and when avoiding it is just fear of losing control
**Suggested tags:** azure, landing-zones, platform-engineering"

update_issue "Deploying Checkpoint NVAs is fun, but also difficult" "**Pillar:** Azure architecture

Wireframe:
- Why organisations still choose third-party NVAs over native Azure Firewall - existing skillset, feature parity, multi-cloud consistency
- The deployment reality - licensing, HA configuration, UDR/route table gotchas, marketplace image quirks, scale set complications
- A specific war story of something that went wrong
- When the operational overhead of a third-party NVA is actually worth it vs native tooling

---
**Suggested title:** Deploying Checkpoint NVAs: Fun, But Difficult
**Suggested subtitle:** The real deployment challenges of running a third-party NVA in Azure, and when the operational overhead is worth it
**Suggested tags:** azure, networking, security, firewall"

update_issue "Change, and fear of change, causes agility problems" "**Pillar:** Technology leadership

Wireframe:
- Companion piece to 'You're not special' - this one focused on the agility cost of fear-driven rigidity, not just the financial cost
- Real examples of technical debt created purely by avoiding change (sticking with legacy naming, avoiding platform upgrades)
- The organisational psychology angle - why fear gets dressed up as 'risk management'
- What leaders can actually do to counter it day to day

---
**Suggested title:** Fear of Change Is an Agility Problem
**Suggested subtitle:** A companion piece to 'You're Not Special' - on the agility cost of fear-driven rigidity, not just the financial one
**Suggested tags:** leadership, change-management, cloud-adoption"

update_issue "Requirements: these are important, otherwise you'll be disappointed" "**Pillar:** Technology leadership

Wireframe:
- The common failure pattern - assumed requirements vs written requirements
- A specific example of a disappointment caused by unclear or missing requirements
- A framework for the minimum requirements discipline that prevents this, without tipping into big-design-up-front
- Reconciling this with agile/iterative delivery - requirements discipline isn't the same as waterfall

---
**Suggested title:** Requirements Matter, Otherwise You'll Be Disappointed
**Suggested subtitle:** The gap between assumed requirements and written requirements, and a minimum discipline that prevents disappointment
**Suggested tags:** leadership, delivery, requirements"

update_issue "Azure Migrate tooling is great; the business case generator is really useful" "**Pillar:** Cloud adoption

Wireframe:
- What Azure Migrate's business case feature actually does - cost and timeline comparisons, assessment data
- Why it's an underrated tool for stakeholder buy-in versus a manual spreadsheet
- A real example of using it to build an actual case
- Limitations to flag - data quality dependency, assumptions baked into the model

---
**Suggested title:** Azure Migrate's Business Case Generator Is Underrated
**Suggested subtitle:** Why Azure Migrate's business case tooling is a better way to win stakeholder buy-in than another spreadsheet
**Suggested tags:** azure, cloud-adoption, migration"

update_issue "Sovereign cloud: ambition vs reality" "**Pillar:** Azure architecture

Wireframe:
- What 'sovereign cloud' actually means in the Microsoft context - Cloud for Sovereignty, EU Data Boundary, and the broader Sovereign Private Cloud stack
- Why demand has accelerated - geopolitical drivers, national regulation, public sector procurement requirements
- The gap between the marketing narrative and what's genuinely deliverable today - real limits, what still needs cloud connectivity
- A framework for evaluating a sovereignty requirement honestly - is this a genuine legal/regulatory need, or a compliance-shaped preference
- Where this is heading, and what's worth watching over the next year

---
**Suggested title:** Sovereign Cloud: Ambition vs Reality
**Suggested subtitle:** What Microsoft's sovereign cloud portfolio genuinely delivers today, and how to tell a real sovereignty requirement from a compliance-shaped preference
**Suggested tags:** azure, sovereign-cloud, governance"

update_issue "Azure Local as sovereign infrastructure: one operating model for Azure and on-prem" "**Pillar:** Azure architecture

Follow-on from the sovereign cloud piece.

Wireframe:
- The problem Azure Local solves - sovereignty/data residency requirements that used to force a completely separate on-prem stack with its own tooling and skills
- What's changed recently - a local control plane independent of Arc, 'Local Identity with Key Vault' for customer-managed keys (including air-gapped), SAN-based storage, scale to thousands of nodes, fully disconnected operation
- The real prize - a genuinely consistent operating model: same Azure look and feel, same skills, same governance patterns, whether workloads run in an Azure region or on customer-owned hardware
- How Microsoft 365 Local and Foundry Local extend this further - productivity and AI workloads staying inside the sovereign boundary too
- Practical guidance for architects - when Azure Local is the right sovereignty answer vs when a connected Azure region with the right compliance boundary is simpler and sufficient
- Real-world reference points - AT&T and Kadaster running Azure Local at scale for exactly this reason

Sources:
https://blogs.microsoft.com/blog/2026/04/27/microsoft-sovereign-private-cloud-scales-to-thousands-of-nodes-with-azure-local/
https://www.theregister.com/on-prem/2026/04/30/microsoft-levels-up-azure-local-for-sovereign-clouds/
https://blogs.microsoft.com/blog/2026/02/24/microsoft-sovereign-cloud-adds-governance-productivity-and-support-for-large-ai-models-securely-running-even-when-completely-disconnected/

---
**Suggested title:** Azure Local: One Operating Model for Azure and On-Prem
**Suggested subtitle:** How Azure Local's recent sovereign cloud upgrades deliver a genuinely consistent operating model across cloud and customer-owned hardware
**Suggested tags:** azure, azure-local, sovereign-cloud, hybrid"

echo "Done."
