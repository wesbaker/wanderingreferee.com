# Wandering Referee — Claude Instructions

## Stack

- **Hugo** v0.160.1 (extended) — static site generator
- **Congo** v2.13.0 — theme, loaded via Hugo Modules (`_vendor/`)
- **Cloudflare Pages** — hosting at wanderingreferee.com

## Hugo Version

The Hugo version is pinned in two places. When upgrading Hugo, update **both**:

1. This file (the version number above)
2. `wrangler.toml` → `[vars]` → `HUGO_VERSION`

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

## Congo Theme Reference

Full docs: <https://jpanther.github.io/congo/docs/>

### Configuration Files

Settings live in `config/_default/`. Key files:

| File | Purpose |
|------|---------|
| `hugo.toml` | Hugo core settings (baseURL, pagination, outputs) |
| `params.toml` | Congo theme parameters (appearance, features, article display) |
| `languages.en.toml` | Language-specific settings (title, author, date format) |
| `menus.en.toml` | Navigation menus |
| `markup.toml` | Hugo markup settings (required for Congo to render correctly) |

#### Selected `params.toml` settings

| Key | Default | Notes |
|-----|---------|-------|
| `colorScheme` | `"congo"` | Options: congo, avocado, cherry, fire, ocean, sapphire, slate |
| `defaultAppearance` | `"light"` | `"light"` or `"dark"` |
| `autoSwitchAppearance` | `true` | Follows OS preference |
| `enableSearch` | `false` | Enables site search |
| `enableCodeCopy` | `false` | Copy button on code blocks |
| `header.layout` | `"basic"` | Options: basic, hamburger, hybrid, custom |
| `homepage.layout` | `"page"` | Options: page, profile, custom |
| `homepage.showRecent` | `false` | Show recent articles on homepage |
| `homepage.recentLimit` | `5` | Max recent articles |
| `article.showDate` | `true` | Publication date |
| `article.showDateUpdated` | `false` | Last-updated date |
| `article.showAuthor` | `true` | Author box |
| `article.showReadingTime` | `true` | Reading time estimate |
| `article.showTableOfContents` | `false` | TOC on articles |
| `article.showTaxonomies` | `false` | Tags/categories on articles |
| `article.showWordCount` | `false` | Word count |
| `article.showPagination` | `true` | Next/previous links |
| `list.showSummary` | `false` | Summaries on list pages |
| `list.groupByYear` | `true` | Group list by year |

Full reference: <https://jpanther.github.io/congo/docs/configuration/>

### Post Front Matter

All parameters are optional and inherit from `params.toml` when not set.

| Key | Default | Notes |
|-----|---------|-------|
| `title` | — | Article title |
| `description` | — | HTML meta description |
| `keywords` | — | SEO keywords |
| `date` | — | Publication date |
| `lastmod` | — | Last-updated date |
| `draft` | `false` | Excludes from build when true |
| `summary` | — | Custom summary (overrides auto-generated) |
| `feature` | `"*feature*"` | Glob pattern to match feature image |
| `featureAlt` | `""` | Alt text for feature image |
| `cover` | `"*cover*"` | Glob pattern for cover image |
| `coverAlt` | (featureAlt) | Alt text for cover image |
| `coverCaption` | — | Caption below cover image |
| `thumbnail` | `"*thumb*"` | Glob pattern for thumbnail |
| `thumbnailAlt` | (featureAlt) | Alt text for thumbnail |
| `externalUrl` | — | Links list item to external URL |
| `canonicalUrl` | (permalink) | Override canonical URL |
| `xml` | `true` | Include in sitemap |
| `robots` | — | Robot directives for this page |
| `showDate` | (config) | Override per-article |
| `showDateUpdated` | (config) | Override per-article |
| `showAuthor` | (config) | Override per-article |
| `showReadingTime` | (config) | Override per-article |
| `showTableOfContents` | (config) | Override per-article |
| `showTaxonomies` | (config) | Override per-article |
| `showWordCount` | (config) | Override per-article |
| `showComments` | (config) | Override per-article |
| `showPagination` | (config) | Override per-article |
| `showBreadcrumbs` | (config) | Override per-article |
| `showSummary` | (config) | Override on list pages |
| `showHeadingAnchors` | (config) | Override per-article |
| `showEdit` | (config) | Override per-article |
| `invertPagination` | (config) | Override per-article |
| `sharingLinks` | (config) | Override per-article |

Full reference: <https://jpanther.github.io/congo/docs/front-matter/>
