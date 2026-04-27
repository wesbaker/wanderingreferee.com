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

Posts live in `src/content/posts/slug.md` (flat, no year directories).
Link posts live in `src/content/posts/slug.md` with a `link:` field in frontmatter.
URLs are `/posts/slug/`.

Content collection schema is in `src/content.config.ts`.

### Post Front Matter

| Key | Required | Notes |
|-----|----------|-------|
| `title` | ✅ | Article title |
| `date` | ✅ | ISO 8601 date |
| `description` | — | HTML meta description and feed summary |
| `tags` | — | Array of strings; defaults to `[]` |
| `draft` | — | Excludes from build when `true` |
| `link` | — | External URL; makes this a link post |

## Architecture

```
src/
  components/        Header, Footer, Sidebar, TOC, PostCard, Pagination
  layouts/           BaseLayout, PostLayout, BasePageLayout
  lib/               content.ts (helpers), feed.ts, site.ts
  pages/             index, about, posts/[slug], tags/[tag], rss.xml
  styles/            global.css (all CSS; no scoped styles)
  content/posts/     markdown content
public/
  fonts/             Cartridge woff2 files
  covers/            post cover images
  favicon*, site.webmanifest
```

## Scripting

Prefer Ruby for any new scripts.

## Redirects

`redirects.csv` contains Cloudflare Bulk Redirect entries mapping old `wesbaker.com/posts/YYYY-MM-DD-slug/` URLs to `wanderingreferee.com/posts/slug/`. Upload to Cloudflare as a Bulk Redirect List on the wesbaker.com zone.
