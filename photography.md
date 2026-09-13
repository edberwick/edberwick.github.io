---
layout: page
title: Photography
subtitle: Motorsport, rugby, and whatever else was worth pointing a camera at
---
<div class="post-list">
  {% assign photo_posts = site.posts | where_exp: "post", "post.categories contains 'photography'" %}
  {% for post in photo_posts %}
  <div class="post-row">
    <div class="post-date">{{ post.date | date: "%d %b" }}<br>{{ post.date | date: "%Y" }}</div>
    <div>
      <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
      {% if post.subtitle %}<p>{{ post.subtitle }}</p>{% endif %}
      <div class="tags">
        {% for tag in post.tags limit:4 %}<span class="tag hi">{{ tag }}</span>{% endfor %}
      </div>
    </div>
  </div>
  {% endfor %}
</div>
