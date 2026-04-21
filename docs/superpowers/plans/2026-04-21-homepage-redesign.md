# Homepage Redesign Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the homepage a gateway to posts by switching from the `profile` layout to the `page` layout, trimming the bio, and moving social links to the footer.

**Architecture:** Three config/content file edits — no template overrides required. Congo's built-in `page` layout and footer menu icon support handle everything natively.

**Tech Stack:** Hugo v0.160.1, Congo v2.13.0, TOML config, Markdown content

---

### Task 1: Switch homepage layout

**Files:**
- Modify: `config/_default/params.toml`

- [ ] **Step 1: Change the layout value**

In `config/_default/params.toml`, change:

```toml
[homepage]
  layout = "profile"
  showRecent = true
  recentLimit = 10
```

to:

```toml
[homepage]
  layout = "page"
  showRecent = true
  recentLimit = 10
```

- [ ] **Step 2: Verify in browser**

Check `http://localhost:1313` — the centered author block (name "Wes Baker", tagline, social icons) should be gone. The page should show the bio text from `content/_index.md` followed by the "Recent" post list.

---

### Task 2: Shorten the homepage bio

**Files:**
- Modify: `content/_index.md`

- [ ] **Step 1: Replace the bio**

Replace the entire body of `content/_index.md` with:

```markdown
---
title: ""
---

Tabletop gamer, RPG referee, and miniature painter. This is where I write about all of it.
```

- [ ] **Step 2: Verify in browser**

Check `http://localhost:1313` — the one-liner should appear above the recent posts list with no visual clutter.

- [ ] **Step 3: Commit tasks 1 and 2**

```bash
git add config/_default/params.toml content/_index.md
git commit -m "Switch homepage to page layout with shortened bio"
```

---

### Task 3: Add social links to footer

**Files:**
- Modify: `config/_default/menus.en.toml`

Congo's footer menu supports items with `Params.icon` which renders SVG icons from `assets/icons/`. The icons `mastodon.svg`, `bluesky.svg`, and `github.svg` all exist in the vendored theme.

- [ ] **Step 1: Add footer menu entries**

Append to `config/_default/menus.en.toml`:

```toml
[[footer]]
  name = "Mastodon"
  url = "https://hachyderm.io/@wesbaker"
  weight = 10
  [footer.params]
    icon = "mastodon"
    rel = "me"

[[footer]]
  name = "Bluesky"
  url = "https://bsky.app/profile/wesbaker.com"
  weight = 20
  [footer.params]
    icon = "bluesky"

[[footer]]
  name = "GitHub"
  url = "https://github.com/wesbaker"
  weight = 30
  [footer.params]
    icon = "github"
```

- [ ] **Step 2: Verify in browser**

Scroll to the bottom of `http://localhost:1313` — Mastodon, Bluesky, and GitHub icons should appear in the footer as links.

- [ ] **Step 3: Commit**

```bash
git add config/_default/menus.en.toml
git commit -m "Add social links to footer"
```
