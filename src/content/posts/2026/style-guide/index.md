---
title: "Style Guide"
date: 2026-04-28 10:04:11.331615000 -04:00
description: "A reference post showing all available markdown styles."
tags:
  - style
  - design
  - markdown
draft: true
externalUrl: "https://example.com"
---

## Heading 2

### Heading 3

#### Heading 4

##### Heading 5

###### Heading 6

Regular paragraph text. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

**Bold text** and *italic text* and ***bold italic text***. You can also use ~~strikethrough~~ and `inline code` within a sentence.

## Lists

### Unordered List

- First item
- Second item
  - Nested item
  - Another nested item
    - Deeply nested item
- Third item

### Ordered List

1. First item
2. Second item
   1. Nested ordered item
   2. Another nested ordered item
3. Third item

### Mixed Lists

1. First ordered item
   - Nested unordered
   - Another nested unordered
2. Second ordered item

## Blockquote

> This is a blockquote. It can span multiple lines and contain **bold**, *italic*, and `inline code`.
>
> It can also have multiple paragraphs.

> Nested blockquotes:
>
> > This is nested inside the first blockquote.

## Code

### Inline Code

Use `npm run dev` to start the development server, or `npm run build` for a production build.

### Code Block (no language)

```
This is a plain code block
with no syntax highlighting.
```

### Code Block (JavaScript)

```javascript
function greet(name) {
  const message = `Hello, ${name}!`;
  console.log(message);
  return message;
}

greet('World');
```

### Code Block (TypeScript)

```typescript
interface Post {
  title: string;
  date: Date;
  tags: string[];
  draft?: boolean;
}

const post: Post = {
  title: 'Style Guide',
  date: new Date(),
  tags: [],
};
```

### Code Block (Shell)

```bash
npm run build
npx astro check
npm test
```

## Table

| Column One | Column Two | Column Three |
|------------|------------|--------------|
| Row 1, Col 1 | Row 1, Col 2 | Row 1, Col 3 |
| Row 2, Col 1 | Row 2, Col 2 | Row 2, Col 3 |
| Row 3, Col 1 | Row 3, Col 2 | Row 3, Col 3 |

### Aligned Table

| Left-aligned | Center-aligned | Right-aligned |
|:-------------|:--------------:|--------------:|
| Left | Center | Right |
| Text | Text | Text |
| More text | More text | More text |

## Links

[External link](https://astro.build) — opens in the same tab.

[Link with title](https://astro.build "Astro — the web framework for content-driven websites")

## Images

Regular inline image:

![Kingdomino at Gen Con 2017](./sample.jpg)

Image with a caption using `<figure>`:

<figure>
  <img src="/style-guide-sample.jpg" alt="Kingdomino at Gen Con 2017" />
  <figcaption>Kingdomino on display at Gen Con 2017 — a clean little tile-laying game.</figcaption>
</figure>

## Horizontal Rule

Below this paragraph is a horizontal rule.

---

## Emphasis Combinations

- **Bold**
- *Italic*
- ***Bold and italic***
- ~~Strikethrough~~
- `Inline code`
- **`Bold inline code`**
- *`Italic inline code`*

## Definition / Description List (HTML)

<dl>
  <dt>Astro</dt>
  <dd>A static site generator optimized for content-driven websites.</dd>
  <dt>Pagefind</dt>
  <dd>A client-side search library that runs after the build.</dd>
</dl>

## Task List

- [x] Completed item
- [ ] Incomplete item
- [x] Another completed item

## Footnotes

Here is a sentence with a footnote.[^1]

[^1]: This is the footnote content.

## Long Paragraph

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui.
