# Wandering Referee — Claude Instructions

## Stack

- **Astro** v6 — static site generator
- **Cloudflare Pages** — hosting at wanderingreferee.com
- **Pagefind** — client-side search (runs after `astro build`)
- **Lora** (Google Fonts) + **Cartridge** (self-hosted woff2) — typography

## Build

```bash
npm run build        # astro build + pagefind index
npm run dev          # dev server at http://localhost:4321
npx astro check      # TypeScript check
npm test             # vitest
```

Cloudflare Pages build: `build.sh` → runs `npm run build`. Output dir: `dist`.

## Content Structure

Posts live in `src/content/posts/YYYY/slug.md` or `src/content/posts/YYYY/slug/index.md` (year subdirectories).
Posts with co-located images use folder bundles: `src/content/posts/YYYY/slug/index.md` + images in the same folder.
Link posts use an `externalUrl:` field in frontmatter. All URLs are `/posts/slug/` (year is ignored for routing).

Content collection schema is in `src/content.config.ts`.

### Post Front Matter

| Key | Required | Notes |
|-----|----------|-------|
| `title` | ✅ | Article title |
| `date` | ✅ | ISO 8601 date |
| `description` | — | HTML meta description and feed summary |
| `tags` | — | Array of strings; defaults to `[]` |
| `draft` | — | Excludes from build when `true` |
| `image` | — | Co-located image path e.g. `./cover.jpg`; processed by Astro's `image()` helper |
| `externalUrl` | — | External URL; makes this a link post |

## Architecture

```
src/
  components/        Header, Footer, Sidebar, TOC, PostCard, Pagination
  layouts/           BaseLayout, PostLayout, BasePageLayout
  lib/               content.ts (helpers), feed.ts, site.ts
  pages/             index, about, posts/[slug], tags/[tag], rss.xml
  styles/            global.css (all CSS; no scoped styles)
  content/posts/     markdown content (YYYY/slug.md or YYYY/slug/index.md)
public/
  fonts/             Cartridge woff2 files
  favicon*, site.webmanifest
```

## Scripting

Prefer Ruby for any new scripts.

## Redirects

`redirects.csv` contains Cloudflare Bulk Redirect entries mapping old `wesbaker.com/posts/YYYY-MM-DD-slug/` URLs to `wanderingreferee.com/posts/slug/`. Upload to Cloudflare as a Bulk Redirect List on the wesbaker.com zone.
