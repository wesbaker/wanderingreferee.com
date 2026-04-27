import { defineCollection } from 'astro:content';
import { glob } from 'astro/loaders';
import { postSchema, slugFromMarkdownEntry } from './lib/content/schemas';

const posts = defineCollection({
  loader: glob({
    base: './src/content/posts',
    pattern: ['*.md', '*/index.md'],
    generateId: ({ entry }) => slugFromMarkdownEntry(entry),
  }),
  schema: postSchema,
});

export const collections = { posts };
