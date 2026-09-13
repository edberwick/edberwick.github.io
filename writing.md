---
layout: page
title: Writing
subtitle: Azure architecture, FinOps, cloud adoption and lessons from delivery
permalink: /writing/
---
<div class="post-list">
  {% assign shown = 0 %}
  {% for post in site.posts %}
    {% unless post.categories contains 'photography' %}
    <div class="post-row">
      <div class="post-date">{{ post.date | date: "%d %b" }}<br>{{ post.date | date: "%Y" }}</div>
      <div>
        <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
        <p>{{ post.excerpt | strip_html | truncate: 160 }}</p>
        <div class="tags">
          {% for tag in post.tags limit:4 %}<span class="tag hi">{{ tag }}</span>{% endfor %}
        </div>
      </div>
    </div>
    {% endunless %}
  {% endfor %}
</div>
