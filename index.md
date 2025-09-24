---
layout: default
title: SHI Collaboration Profiles
---

# {{ site.title }}

Welcome to the Sustainable Horizons Institute collaboration profiles. Here you can find information about our collaborators, researchers, and contributors.

## Our Collaborators

<div class="profiles-grid">
{% assign profiles_sorted = site.profiles | sort: 'name' %}
{% for profile in profiles_sorted %}
  <div class="profile-card">
    {% if profile.image %}
      <img src="{{ profile.image | relative_url }}" alt="{{ profile.name }}" class="profile-card-image">
    {% else %}
      <div class="profile-card-image-placeholder">
        <span>{{ profile.name | slice: 0 | upcase }}</span>
      </div>
    {% endif %}
    
    <div class="profile-card-content">
      <h3><a href="{{ profile.url | relative_url }}">{{ profile.name }}</a></h3>
      <p class="profile-card-title">{{ profile.title }}</p>
      <p class="profile-card-org">{{ profile.organization }}</p>
      <p class="profile-card-bio">{{ profile.bio | truncate: 120 }}</p>
      
      <div class="profile-card-links">
        {% if profile.email %}
          <a href="mailto:{{ profile.email }}" title="Email {{ profile.name }}">📧</a>
        {% endif %}
        {% if profile.linkedin %}
          <a href="{{ profile.linkedin }}" target="_blank" title="LinkedIn Profile">💼</a>
        {% endif %}
        {% if profile.github and profile.github != "" %}
          <a href="{{ profile.github }}" target="_blank" title="GitHub Profile">👨‍💻</a>
        {% endif %}
        {% if profile.website and profile.website != "" %}
          <a href="{{ profile.website }}" target="_blank" title="Personal Website">🌐</a>
        {% endif %}
      </div>
    </div>
  </div>
{% endfor %}
</div>

## About This Site

This site is built with Jekyll and uses CSV data to automatically generate profile pages for each collaborator. The profiles are updated automatically when the CSV data file is modified.

### Features

- **Responsive Design**: Works on desktop and mobile devices
- **CSV-Driven**: Profile data is managed in a simple CSV file
- **GitHub Pages Compatible**: Automatically deploys with GitHub Pages
- **SEO Friendly**: Includes meta tags and structured data
- **Primer Theme**: Uses GitHub's Primer design system