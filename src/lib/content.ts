import { getCollection } from 'astro:content';

export async function getPublishedEntries() {
  const posts = await getCollection('posts', ({ data }) => !data.draft);

  return { posts };
}

export async function getAllTags() {
  const { posts } = await getPublishedEntries();

  return [...new Set(posts.flatMap((post) => post.data.tags))].sort((a, b) => a.localeCompare(b));
}

export function formatPostDate(date: Date): string {
  return date.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
}
