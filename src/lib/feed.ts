import type { CollectionEntry } from 'astro:content';

export type PostFeedItem = {
  type: 'post';
  entry: CollectionEntry<'posts'>;
  date: Date;
};

export type FeedItem = PostFeedItem;

export function mergeFeed<T extends { date: Date }>(...groups: T[][]): T[] {
  return groups.flat().sort((a, b) => b.date.valueOf() - a.date.valueOf());
}

export function excerptFromMarkdown(markdown = '', maxLength = 220): string {
  const firstTextBlock = markdown
    .split(/\n{2,}/)
    .map((block) => block.trim())
    .find((block) => block && !block.startsWith('#') && !block.startsWith('!['));

  if (!firstTextBlock) return '';

  const plain = firstTextBlock
    .replace(/```[\s\S]*?```/g, '')
    .replace(/`([^`]+)`/g, '$1')
    .replace(/!\[([^\]]*)\]\([^)]+\)/g, '$1')
    .replace(/\[([^\]]+)\]\([^)]+\)/g, '$1')
    .replace(/[*_~>#-]/g, '')
    .replace(/\s+/g, ' ')
    .trim();

  if (plain.length <= maxLength) return plain;

  const truncated = plain.slice(0, maxLength + 1);
  return `${truncated.slice(0, truncated.lastIndexOf(' ')).trim()}...`;
}
