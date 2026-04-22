# Worklog

## 2026-04-21
- Redesigned homepage with a two-column layout: posts on the left, sidebar on the right with bio, tag pills, and social links
- Switched homepage from `profile` layout to a custom Congo layout (`layouts/_partials/home/custom.html`)
- Removed redundant "Recent" heading from post list
- Added 4px bottom margin to article title h3 in listings
- Bumped site title font size to 1.875rem using Cartridge font
- Widened TOC sidebar to 22rem on article pages
- Removed dead CSS and cleaned up PR

## 2026-04-21 (earlier)
- Added Cartridge font for headings and site title (merged via PR #5)

## 2026-04-20
- Added link post for rewriting article
- Added link post archetype

## 2026-04-11
- Removed migration scripts and artifacts
- Added `new-post` skill and started tracking `.claude/` directory (PR #4)
- Updated CLAUDE.md and symlinked to AGENTS.md
- Fixed frontmatter for RPGaDay posts (PR #3)
- Added summary to Blights of Eastern Forest article (PR #2)
- Added Hugo build check for PRs
- Removed rounded corners from favicon
- Added favicon (parchment map with dotted trail and X marker)
- Added missing post and fixed preview deployments (PR #1)
- Added Plausible analytics via extend-head.html

## 2026-04-10
- Overrode head.html to use RelPermalink for CSS/JS assets
- Set up Cloudflare Pages redirect from wanderingreferee.pages.dev to wanderingreferee.com
- Updated .gitignore
- Initial commit
