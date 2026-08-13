source "https://rubygems.org"

# Pins the exact Jekyll + plugin versions used by GitHub Pages' production
# build infrastructure. No version is pinned explicitly here; whatever the
# github-pages gem currently maps to is what gets installed, which mirrors
# GitHub Pages' live build environment as closely as possible.
gem "github-pages", group: :jekyll_plugins

# Required for `jekyll serve` on Ruby 3.0+, where webrick was removed from
# the standard library. Does not affect the GitHub Pages production build
# (which is not run via this Gemfile) and does not add or change any
# Jekyll plugin behavior.
gem "webrick"
