# bubblewrap

A personal Jekyll site for programming notes, music, internet curiosities, and whatever else is worth writing down.

Live site: <https://shuvraneelmitra.github.io>

## Stack

- Jekyll
- Kramdown + Rouge
- GitHub Pages
- `jekyll-feed`, `jekyll-seo-tag`, and `jekyll-sitemap`
- Plain CSS — no JavaScript framework or frontend build step

## Repository structure

- `_config.yml` — site-wide configuration, URLs, Markdown, plugins, and metadata.
- `_posts/` — dated Markdown posts. Categories come from post front matter.
- `_layouts/` — page, archive, category, and post templates.
- `_includes/` — shared head, header, and footer markup.
- `assets/css/style.css` — the site's complete stylesheet.
- `Music.md`, `Programming.md`, `Random.md` — stable category landing pages. Their URLs are intentionally preserved.
- `all-blogs.html` — the complete archive.
- `404.html` — custom not-found page.
- `robots.txt` — crawler instructions and sitemap location.
- `.github/workflows/pages.yml` — GitHub Pages build and deployment workflow.

## URLs

Existing public URLs are intentionally preserved:

- `/`
- `/all-blogs/`
- `/Music/`
- `/Programming/`
- `/Random/`
- `/<Category>/<post-title>/`
- `/feed.xml`
- `/sitemap.xml`

## Adding a post

Create a dated file in `_posts/`:

```yaml
---
layout: post
title: "Your title"
date: 2026-08-14
categories: [Random]
description: "A short description for the archive and SEO metadata."
---

Your Markdown goes here.
```

For posts containing LaTeX, add:

```yaml
math: true
```

This loads MathJax only for pages that need it.

If you add a brand-new category, also create a small category page with its desired public URL. The navigation is generated automatically from `site.categories`; there is no category-generation script anymore.

## Local development

Ruby and Bundler are required. The repository includes a `Gemfile` using the `github-pages` gem plus `webrick` for local serving.

```sh
bundle install
bundle exec jekyll serve
```

Then open <http://localhost:4000>.

If Ruby is not installed on Windows, use RubyInstaller with DevKit or a Linux/WSL Ruby environment.

## Deployment

The site is deployed by GitHub Actions. The workflow builds the Jekyll site and publishes the generated Pages artifact.

In the repository's GitHub settings, set **Pages → Build and deployment → Source** to **GitHub Actions** before the first deployment.
