---
layout: page
title: "Blogs about Nice Programming Problems"
permalink: /programming/
---

<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      <span style="color:gray;">— {{ post.date | date: "%b %d, %Y" }}</span>
    </li>
  {% endfor %}
</ul>
