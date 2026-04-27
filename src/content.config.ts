import { defineCollection } from 'astro:content';
import { glob } from 'astro/loaders';
import { z } from 'astro/zod';
import { optionalStringSchema, slugFromMarkdownEntry, tagsSchema } from './lib/content/schemas';

const posts = defineCollection({
  loader: glob({
    base: './src/content/posts',
    pattern: ['*.md', '*/index.md', '*/*.md', '*/*/index.md'],
    generateId: ({ entry }) => slugFromMarkdownEntry(entry),
  }),
  schema: ({ image }) =>
    z.object({
      title: z.string().min(1),
      date: z.coerce.date(),
      description: optionalStringSchema,
      tags: tagsSchema,
      draft: z.boolean().default(false),
      image: image().optional(),
      externalUrl: optionalStringSchema,
    }),
});

export const collections = { posts };
