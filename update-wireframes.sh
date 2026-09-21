#!/bin/bash
# Updates the body of each existing backlog issue to add a Wireframe section.
# Looks up each issue by its exact title, so order/numbering doesn't matter.
# Run from anywhere once `gh repo set-default` has been set.

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
- Closing take: budget and resource the landing zone as an ongoing platform function, not a project with an end date"

update_issue "When to deviate from the Microsoft reference architecture" "**Pillar:** Azure architecture

Wireframe:
- The reference architecture is a strong default, not a mandate
- Real reasons to deviate: regulatory requirement, existing investment, genuine scale/performance need
- Bad reasons to deviate: familiarity, fear, 'we've always done it this way' (ties to the customisation/change theme)
- A framework for justifying a deviation to a review board or client - documenting the trade-off, not just the decision
- A real example of a deviation that was justified, and one that wasn't"

update_issue "An asymmetric-routing gotcha from a recent hub-and-spoke build" "**Pillar:** Azure architecture

Wireframe:
- Set the scene: a hub-and-spoke topology that looked textbook-correct
- The specific symptom that surfaced - inconsistent or dropped traffic, hard to reproduce
- The diagnosis process - what was checked first, the red herrings, what actually found it (UDRs, NVA routing asymmetry, NAT)
- The fix
- The broader lesson: how to test for this class of problem before it hits production"

update_issue "Why cost anomaly alerts are useless without an owner attached" "**Pillar:** FinOps

Wireframe:
- The common setup: cost anomaly detection turned on, alert fires, goes to a shared inbox nobody checks
- Why this happens organisationally - cost ownership is diffuse, nobody's job description says 'investigate cost alerts'
- What 'useful' actually looks like - alert routed to a named owner, expected response SLA, tied to the business owner of that subscription or resource group
- A short framework for setting this up properly
- A real example of an anomaly that would have been caught early with proper ownership"

update_issue "FOCUS 1.1 in practice: what changed and is it worth adopting now" "**Pillar:** FinOps

Wireframe:
- Quick primer on what FOCUS is and why it exists - cross-cloud cost data standardisation
- What's actually new or different in 1.1 versus prior versions
- The migration effort required from existing Cost Management exports
- Is it worth adopting now, or wait - a genuine cost/benefit call, not hype
- Where to start if you decide to move"

update_issue "A cost decision that looked wrong on the invoice but was right for the business" "**Pillar:** FinOps

Wireframe:
- The setup: a specific decision that, viewed purely on the invoice, looked like overspend
- The business context that changed the calculus - risk avoidance, speed to market, team capacity
- Why FinOps needs to resist becoming pure cost minimisation
- A framework for evaluating 'is this actually wasteful, or does it just look wasteful'
- Closing take: FinOps is about value, and value isn't always the cheapest line item"

update_issue "The operating-model conversation that should happen before the migration plan" "**Pillar:** Cloud adoption

Wireframe:
- The common pattern: the migration plan gets built and approved before anyone asks 'who runs this once it's live'
- What goes wrong when operating model is an afterthought - unclear ownership, support gaps, tooling mismatches
- A short framework for the operating-model questions that should be answered in week one, not month six
- A real example of a migration that succeeded technically but struggled operationally because of this gap"

update_issue "What cloud maturity actually looks like 18 months post-migration" "**Pillar:** Cloud adoption

Wireframe:
- The vendor pitch at the start of a migration vs the reality 18 months later
- Honest markers of maturity - not 'how many workloads migrated' but incident response time, cost visibility, team confidence, governance drift
- A grounded, anonymised case study of where an organisation actually landed
- What 'good' realistically looks like at 18 months, versus the unrealistic bar often set at kickoff"

update_issue "A retrospective on a transformation programme that stalled" "**Pillar:** Cloud adoption

Wireframe:
- Set the scene: the programme, the ambition, where it stalled
- Root causes - technical, organisational, or both (specific but anonymised)
- What would have needed to be true for it to succeed
- What restarted it, if it did, or what the current state actually is
- The broader lesson for anyone starting a similar programme"

update_issue "Repeatable platforms vs bespoke builds in regulated environments" "**Pillar:** Platform & operations

Wireframe:
- The tension - platform engineering wants standard, reusable patterns; regulated environments often demand case-by-case justification
- Where the line genuinely needs to sit - always standardise security baselines vs where bespoke is legitimate
- A framework for evaluating a bespoke request - is it regulation, or preference dressed up as regulation
- A real example from delivery"

update_issue "A walkthrough of an Azure Verified Module and what it saved" "**Pillar:** Platform & operations

Wireframe:
- Pick a specific AVM used in a real build
- Before/after - what it would have taken to write and test this from scratch vs adopting the module
- Any friction encountered adopting it - versioning, customisation limits
- The actual time or effort saved, with real numbers if possible
- When AVMs are, and aren't, the right call"

update_issue "Managed services: the SLA conversation nobody wants to have" "**Pillar:** Platform & operations

Wireframe:
- Why this conversation gets avoided - it feels awkward and adversarial, easier to assume good faith
- What happens when it's skipped - a real incident where unclear SLA expectations caused a problem
- What a good SLA conversation actually covers - response times, escalation, ownership boundaries, what's explicitly out of scope
- A framework for having this conversation early, framed collaboratively rather than adversarially"

update_issue "What changes about decision-making once you're managing the team making them" "**Pillar:** Technology leadership

Wireframe:
- The shift from personally making the right call to enabling someone else to make it
- A specific example of a decision you'd have made differently yourself, but let stand because it was right for the team's growth
- The skills this actually requires - asking better questions, tolerating a different route to the same outcome
- What doesn't change - technical judgement is still needed, just applied differently"

update_issue "A time I overruled my own architecture instinct for an org reason" "**Pillar:** Technology leadership

Wireframe:
- Set the scene - the technical call your instinct wanted to make
- The organisational reason it got overruled - political, budget, timeline, team capability
- Honest reflection - was it the right call in hindsight, or not
- What this teaches about the gap between 'technically correct' and 'organisationally viable'"

update_issue "Building psychological safety on a platform team without losing pace" "**Pillar:** Technology leadership

Wireframe:
- The false trade-off often assumed between psychological safety and delivery speed
- What actually erodes psychological safety on a technical team - blame culture after incidents, dismissing junior input, unclear ownership
- Concrete practices that build both safety and pace - blameless postmortems, clear decision rights, room to disagree before a decision locks in
- A real example from your own team"

update_issue "You're not special: the cost of customising instead of adopting" "**Pillar:** Cloud adoption

Wireframe:
- Open with the Birmingham City Council Oracle figures (GBP19.9m budgeted, over GBP216m and counting) as the anchor example
- Pair with the first-hand Michael Page CRM customisation story
- Core thesis - most organisations aren't special enough to justify the cost and risk of heavy customisation
- The psychological pattern - fear of change dressed up as a business requirement
- A framework for challenging a customisation request - is this a genuine business differentiator, or discomfort with change
- Closing take

Source: https://www.linkedin.com/posts/giles-lancaster_total-cost-of-birmingham-citys-oracle-system-activity-7504099020114620416-NMi9"

echo "Done."
