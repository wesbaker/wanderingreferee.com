# wanderingreferee.com

Source for [wanderingreferee.com](https://wanderingreferee.com) — a personal blog about board games, tabletop RPGs, and related hobbies.

## Stack

- [Astro](https://astro.build) — static site generator
- [Cloudflare Pages](https://pages.cloudflare.com) — hosting
- [Pagefind](https://pagefind.app) — client-side search index, built after Astro
- Lora (Google Fonts) and Cartridge (self-hosted woff2) — typography

## Local Development

Requires Node.js 22.12 or newer.

```bash
npm install
npm run dev
```

The development server runs at <http://localhost:4321>. Other useful commands:

```bash
npm test          # run the Vitest suite
npx astro check   # type-check the site
npm run build     # build Astro and the Pagefind index
npm run preview   # preview the production build
```

Cloudflare Pages runs `build.sh`, which builds the site into `dist`.

## Content Structure

Posts live in `src/content/posts/YYYY/slug.md` or, when they have co-located images, in `src/content/posts/YYYY/slug/index.md`. URLs are `/posts/slug/`; the year is not part of the URL.

Each post needs this frontmatter:

```yaml
---
title: My Post
date: 2026-08-30
---
```

Optional fields include `description`, `tags`, `draft`, `image`, `externalUrl`, and `subtitle`. Use `externalUrl` for a link post; it keeps a local permalink while sending readers to the external destination.

## Configuration

The content collection schema lives in `src/content.config.ts`. See `CLAUDE.md` for the full project reference, including post presentation and redirect conventions.
