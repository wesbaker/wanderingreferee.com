# Wandering Referee — Claude Instructions

## Stack

- **Hugo** v0.160.1 (extended) — static site generator
- **Congo** v2.13.0 — theme, loaded via Hugo Modules (`_vendor/`)
- **Cloudflare Pages** — hosting at wanderingreferee.com

## Hugo Version

The Hugo version is pinned in two places. When upgrading Hugo, update **both**:

1. This file (the version number above)
2. Cloudflare Pages → Settings → Environment variables → `HUGO_VERSION`

## Content Structure

Posts live in `content/posts/YEAR/slug/index.md` (leaf bundles).
URLs are `/posts/slug/` — no year or date in the URL (configured via `:contentbasename` permalink).
Page resources (images) go in the same directory as `index.md`.

## Theme Overrides

Local template overrides in `layouts/` take precedence over Congo:

- `layouts/_partials/functions/warnings.html` — removes broken `.Site.Author` check (Congo #1149, incompatible with Hugo v0.156+)
- `layouts/_partials/recent-articles.html` — adds "All posts →" link below recent posts on homepage

When upgrading Congo, re-check these overrides against the new theme version.

## Scripting

Migration and restructuring scripts are in the repo root (`migrate_posts.rb`, `restructure_posts.rb`).
Prefer Ruby for any new scripts.

## Redirects

`redirects.csv` contains Cloudflare Bulk Redirect entries mapping old `wesbaker.com/posts/YYYY-MM-DD-slug/` URLs to `wanderingreferee.com/posts/slug/`. Upload to Cloudflare as a Bulk Redirect List on the wesbaker.com zone.
