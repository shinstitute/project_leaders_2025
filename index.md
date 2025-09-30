---
layout: default
title: SHI BE@US-RSE25 Participant Profiles
description: Profile pages for Sustainable Horizons Institute BE@US-RSE25 participants 
---
## Our Participants

<div class="profiles-grid">
{% for profile in site.profiles %}
  <div class="profile-card">
    {% if profile.image %}
      <div class="profile-card-image">
        <img src="{{ profile.image | relative_url }}" alt="{{ profile.name }}" />
      </div>
    {% else %}
      <div class="profile-card-image-placeholder">
        <span>{{ profile.name | slice: 0 }}</span>
      </div>
    {% endif %}
    
    <div class="profile-card-content">
      <h3><a href="{{ profile.url | relative_url }}">{{ profile.name }}</a></h3>
      {% if profile.project_title %}
        <p class="profile-card-title">{{ profile.project_title }}</p>
      {% endif %}
      <p class="profile-card-org">{{ profile.organization }}</p>
      {% if profile.academic_interests %}
        <p class="profile-card-bio">{{ profile.academic_interests | truncate: 150 }}</p>
      {% endif %}
      
      <div class="profile-card-links">
        {% if profile.email %}
          <a href="mailto:{{ profile.email }}" title="Email {{ profile.name }}">📧</a>
        {% endif %}
        {% if profile.website %}
          <a href="{{ profile.website }}" title="Visit {{ profile.name }}'s website" target="_blank">🌐</a>
        {% endif %}
        {% if profile.github %}
          <a href="{{ profile.github }}" title="View {{ profile.name }}'s GitHub" target="_blank">🐙</a>
        {% endif %}
        {% if profile.linkedin %}
          <a href="{{ profile.linkedin }}" title="View {{ profile.name }}'s LinkedIn" target="_blank">💼</a>
        {% endif %}
      </div>
    </div>
  </div>
{% endfor %}
</div>

