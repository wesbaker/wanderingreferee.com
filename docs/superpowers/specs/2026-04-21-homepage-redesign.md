# Homepage Redesign

**Date:** 2026-04-21

## Goal

Make the homepage a gateway to posts rather than a profile/identity page. The current `profile` layout leads with a centered name, tagline, bio paragraph, and social icons — all before the user reaches any posts.

## Changes

### 1. `config/_default/params.toml`
Change `homepage.layout` from `"profile"` to `"page"`.

This removes the centered author block (name, tagline, social icons) and replaces it with the content from `content/_index.md` followed by the recent posts list.

### 2. `content/_index.md`
Replace the long bio paragraph with a single short line:

> "Tabletop gamer, RPG referee, and miniature painter. This is where I write about all of it."

### 3. `config/_default/menus.en.toml`
Add `[[footer]]` entries for Mastodon, Bluesky, and GitHub using Congo's built-in icon support. Congo already has `mastodon.svg`, `bluesky.svg`, and `github.svg` icons. No template override needed.

## Out of Scope

- Any changes to the recent posts list, article-link template, or other pages.
