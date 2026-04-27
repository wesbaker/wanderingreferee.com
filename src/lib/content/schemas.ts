import { z } from 'astro/zod';

export const tagsSchema = z.preprocess((value) => {
  if (value == null) return [];
  if (typeof value === 'string') return [value];
  return value;
}, z.array(z.string()).default([]));

export const optionalStringSchema = z.preprocess((value) => {
  if (value == null || value === '') return undefined;
  return value;
}, z.string().optional());

// Standalone schema used in tests. Image is a plain optional string here —
// the live collection schema (content.config.ts) uses Astro's image() helper
// so Astro can process co-located images with optimisation.
export const postSchema = z.object({
  title: z.string().min(1),
  date: z.coerce.date(),
  description: optionalStringSchema,
  tags: tagsSchema,
  draft: z.boolean().default(false),
  image: optionalStringSchema,
  externalUrl: optionalStringSchema,
});

export type PostFrontmatter = z.infer<typeof postSchema>;

export function slugFromMarkdownEntry(entry: string): string {
  const parts = entry.split('/').filter(Boolean);
  const filename = parts.at(-1);

  if (!filename?.endsWith('.md')) {
    throw new Error(`Expected a Markdown entry path, received: ${entry}`);
  }

  // folder/index.md or YYYY/folder/index.md → use the folder name as the slug
  if (filename === 'index.md' && parts.length >= 2) {
    return parts.at(-2)!;
  }

  return filename.slice(0, -'.md'.length);
}
