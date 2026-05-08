import { getCollection } from 'astro:content';

export function showDrafts(): boolean {
  return import.meta.env.DEV || import.meta.env.PUBLIC_SHOW_DRAFTS === 'true';
}

export async function getEntries() {
  const posts = await getCollection('posts', ({ data }) => !data.draft || showDrafts());

  return { posts };
}

export async function getAllTags() {
  const { posts } = await getEntries();

  return [...new Set(posts.flatMap((post) => post.data.tags))].sort((a, b) => a.localeCompare(b));
}

export function formatPostDate(date: Date): string {
  return date.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
}
