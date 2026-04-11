# wanderingreferee.com

Source for [wanderingreferee.com](https://wanderingreferee.com) — a personal blog about board games, tabletop RPGs, and related hobbies.

## Stack

- [Hugo](https://gohugo.io) v0.160.1 (extended) — static site generator
- [Congo](https://jpanther.github.io/congo/) v2.13.0 — theme, loaded via Hugo Modules (`_vendor/`)
- [Cloudflare Pages](https://pages.cloudflare.com) — hosting

## Local Development

```bash
hugo server
```

## Content Structure

Posts live in `content/posts/YEAR/slug/index.md` (Hugo leaf bundles). URLs are `/posts/slug/` — no year in the URL. Images go in the same directory as `index.md`.

## Creating a New Post

Use the `new-post` Claude skill:

```
/new-post
```

It will prompt for a title (and optionally a slug), then scaffold:

```
content/posts/{year}/{slug}/
└── index.md
```

With frontmatter:

```yaml
---
title: ""
date: 2026-04-11 15:30:00.000000000 -04:00
summary: ""
feature:
featureAlt:
tags:
  -
---
```

The date is set from the current system time — never inferred.

## Configuration

Settings live in `config/_default/`. See `CLAUDE.md` for a full reference.
