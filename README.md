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

Standard post:

```bash
hugo new content posts/2026/my-post/index.md
```

Link post:

```bash
hugo new content posts/2026/my-link-post/index.md --kind link
```

Both commands create a leaf bundle at:

```text
content/posts/{year}/{slug}/
└── index.md
```

The local `link` archetype scaffolds front matter like:

```toml
+++
date = '2026-04-20T12:34:56-04:00'
draft = true
title = 'My Link Post'
linkUrl = ''
summary = ''
showReadingTime = false
+++
```

Set `linkUrl` to the destination URL. Link posts render as normal permalinked posts on this site, while list pages and the article header expose the external URL alongside the local permalink.

## Configuration

Settings live in `config/_default/`. See `CLAUDE.md` for a full reference.
