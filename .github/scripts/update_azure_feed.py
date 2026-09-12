"""
Fetches the official Azure updates RSS feed and writes the newest items
into _data/azure_updates.yml, in the schema the Signal panel expects:

  - text: "<update title>"
    meta: "<Topic> · <relative time>"
    dot: blue | avanade | amber | cyan

Run by .github/workflows/azure-updates.yml on a schedule.
"""
import re
import sys
from datetime import datetime, timezone
from email.utils import parsedate_to_datetime

import requests
import yaml

FEED_URL = "https://www.microsoft.com/releasecommunications/api/v2/azure/rss"
OUTPUT_PATH = "_data/azure_updates.yml"
MAX_ITEMS = 4

# Status-style categories to skip when picking a display "topic" label
STATUS_CATEGORIES = {
    "launched", "in preview", "in development", "retirements",
    "announcement", "features", "feature", "services", "service",
}


def pick_topic(categories):
    for cat in categories:
        if cat.strip().lower() not in STATUS_CATEGORIES:
            return cat.strip()
    return categories[0].strip() if categories else "Azure"


def pick_dot(categories):
    joined = " ".join(categories).lower()
    if "security" in joined:
        return "avanade"
    if "cost" in joined or "pricing" in joined or "finops" in joined:
        return "amber"
    if "ai " in joined or "machine learning" in joined or "foundry" in joined:
        return "cyan"
    return "blue"


def relative_time(pub_date):
    now = datetime.now(timezone.utc)
    days = (now - pub_date).days
    if days <= 0:
        return "Today"
    if days == 1:
        return "Yesterday"
    if days < 7:
        return f"{days} days ago"
    weeks = days // 7
    if weeks == 1:
        return "1 week ago"
    if weeks < 5:
        return f"{weeks} weeks ago"
    return pub_date.strftime("%b %Y")


def clean_title(title):
    # Strip leading "[Launched] " / "[In preview] " style tags - the meta
    # line already shows a topic, so this keeps the headline readable.
    return re.sub(r"^\[[^\]]+\]\s*", "", title).strip()


def main():
    resp = requests.get(FEED_URL, timeout=20)
    resp.raise_for_status()

    import xml.etree.ElementTree as ET
    root = ET.fromstring(resp.content)
    items = root.findall("./channel/item")[:MAX_ITEMS]

    if not items:
        print("No items found in feed - leaving existing data file untouched.")
        sys.exit(0)

    entries = []
    for item in items:
        title = (item.findtext("title") or "").strip()
        categories = [c.text for c in item.findall("category") if c.text]
        pub_date_raw = item.findtext("pubDate") or ""
        try:
            pub_date = parsedate_to_datetime(pub_date_raw)
            if pub_date.tzinfo is None:
                pub_date = pub_date.replace(tzinfo=timezone.utc)
        except Exception:
            pub_date = datetime.now(timezone.utc)

        entries.append({
            "text": clean_title(title),
            "meta": f"{pick_topic(categories)} \u00b7 {relative_time(pub_date)}",
            "dot": pick_dot(categories),
        })

    with open(OUTPUT_PATH, "w") as f:
        yaml.dump(entries, f, allow_unicode=True, sort_keys=False, default_flow_style=False)

    print(f"Wrote {len(entries)} entries to {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
