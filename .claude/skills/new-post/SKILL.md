---
name: new-post
description: Use when creating a new blog post for wanderingreferee.com — scaffolds the directory and index.md with correct frontmatter
---

# New Post

Creates a new blog post at `content/posts/{year}/{slug}/index.md` with standard frontmatter.

## Steps

1. **Get title and slug** — if not already provided, ask the user for:
   - Post title (required)
   - Slug (optional — derive from title if omitted: lowercase, spaces→hyphens, strip non-alphanumeric except hyphens)

2. **Get current year** — run this exact command, never infer:
   ```bash
   date +%Y
   ```

3. **Get current datetime** — run:
   ```bash
   ruby -e "puts Time.now.strftime('%Y-%m-%d %H:%M:%S.%9N %:z')"
   ```
   Example output: `2026-04-11 15:30:00.000000000 -04:00`

4. **Create the directory**:
   ```bash
   mkdir -p content/posts/{year}/{slug}
   ```

5. **Write `content/posts/{year}/{slug}/index.md`** with this frontmatter:
   ```markdown
   ---
   title: "{title}"
   date: {datetime}
   summary: ""
   feature: 
   featureAlt: 
   tags:
   - 
   ---
   ```

## Slug Derivation Rules

- Lowercase everything
- Replace spaces with hyphens
- Remove characters that are not alphanumeric or hyphens
- Collapse multiple hyphens into one
- Strip leading/trailing hyphens

Example: `"My First Post!"` → `my-first-post`
