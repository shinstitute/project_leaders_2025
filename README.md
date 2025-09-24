# SHI Collaboration Profiles

A GitHub Pages site for displaying profile pages of Sustainable Horizons Institute collaborators. This site uses Jekyll with the Primer theme and generates profile pages from CSV data.

## Features

- **Responsive Design**: Works on desktop and mobile devices
- **CSV-Driven Profiles**: Profile data can be managed in CSV format
- **GitHub Pages Compatible**: Automatically deploys with GitHub Pages
- **SEO Friendly**: Includes meta tags and structured data
- **Primer Theme**: Uses GitHub's Primer design system

## Site Structure

```
├── _config.yml              # Jekyll configuration
├── _data/
│   ├── profiles.csv         # CSV profile data (for reference)
│   └── profiles.yml         # YAML profile data (used by Jekyll)
├── _layouts/
│   ├── default.html         # Main site layout
│   └── profile.html         # Individual profile page layout
├── _profiles/               # Individual profile pages
│   ├── john-smith.md
│   ├── jane-doe.md
│   └── ...
├── assets/css/
│   └── custom.css           # Custom styling
├── index.md                 # Homepage listing all profiles
└── scripts/
    └── csv_to_profiles.rb   # Helper script to convert CSV to profile pages
```

## Adding New Profiles

### Method 1: Manual Creation

Create a new file in `_profiles/` directory:

```markdown
---
layout: profile
name: "Your Name"
title: "Your Title"
organization: "Your Organization"
email: "your.email@example.com"
bio: "Brief description of your background and interests."
image: "/assets/images/your-name.jpg"
linkedin: "https://linkedin.com/in/yourprofile"
github: "https://github.com/yourusername"
website: "https://yourwebsite.com"
---

## Additional Information

Add any additional content here using markdown.
```

### Method 2: CSV Import

1. Update `_data/profiles.csv` with new profile data
2. Run the conversion script: `ruby scripts/csv_to_profiles.rb`
3. Commit the generated profile files

## Local Development

1. Install Ruby and Jekyll:
   ```bash
   gem install jekyll bundler
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Run the local server:
   ```bash
   bundle exec jekyll serve
   ```

4. Visit http://localhost:4000 to view the site

## Deployment

This site is configured for GitHub Pages deployment:

1. Push changes to the main branch
2. Enable GitHub Pages in repository settings
3. Select source as "Deploy from a branch" and choose "main"
4. The site will be available at https://yourusername.github.io/shi-collab/

## Customization

- **Styling**: Modify `assets/css/custom.css` for visual customizations
- **Layout**: Edit files in `_layouts/` to change page structure
- **Content**: Update `index.md` for homepage content
- **Configuration**: Modify `_config.yml` for site settings
