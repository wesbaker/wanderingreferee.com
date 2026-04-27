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
  description: optionalStringSchema,
  keywords: tagsSchema.optional(),
  date: z.coerce.date(),
  lastmod: z.coerce.date().optional(),
  draft: z.boolean().default(false),
  summary: optionalStringSchema,
  tags: tagsSchema,
  image: optionalStringSchema,
  feature: optionalStringSchema,
  featureAlt: optionalStringSchema,
  cover: optionalStringSchema,
  coverAlt: optionalStringSchema,
  coverCaption: optionalStringSchema,
  thumbnail: optionalStringSchema,
  thumbnailAlt: optionalStringSchema,
  externalUrl: optionalStringSchema,
  canonicalUrl: optionalStringSchema,
  xml: z.boolean().default(true),
  robots: optionalStringSchema,
  showDate: z.boolean().optional(),
  showDateUpdated: z.boolean().optional(),
  showAuthor: z.boolean().optional(),
  showReadingTime: z.boolean().optional(),
  showTableOfContents: z.boolean().optional(),
  showTaxonomies: z.boolean().optional(),
  showWordCount: z.boolean().optional(),
  showComments: z.boolean().optional(),
  showPagination: z.boolean().optional(),
  showBreadcrumbs: z.boolean().optional(),
  showSummary: z.boolean().optional(),
  showHeadingAnchors: z.boolean().optional(),
  showEdit: z.boolean().optional(),
  invertPagination: z.boolean().optional(),
  sharingLinks: tagsSchema.optional(),
});

export type PostFrontmatter = z.infer<typeof postSchema>;

export function slugFromMarkdownEntry(entry: string): string {
  const filename = entry.split('/').filter(Boolean).at(-1);

  if (!filename?.endsWith('.md')) {
    throw new Error(`Expected a Markdown entry path, received: ${entry}`);
  }

  return filename.slice(0, -'.md'.length);
}
