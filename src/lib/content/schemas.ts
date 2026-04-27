import { z } from 'astro/zod';

const tagsSchema = z.preprocess((value) => {
  if (value == null) return [];
  if (typeof value === 'string') return [value];
  return value;
}, z.array(z.string()).default([]));

const optionalStringSchema = z.preprocess((value) => {
  if (value == null || value === '') return undefined;
  return value;
}, z.string().optional());

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

  // folder/index.md → use the folder name as the slug
  if (filename === 'index.md' && parts.length >= 2) {
    return parts.at(-2)!;
  }

  return filename.slice(0, -'.md'.length);
}
