import { describe, expect, it } from 'vitest';
import { mergeFeed } from './feed';

type TestFeedItem = {
  date: Date;
  type: 'post';
  slug: string;
  title: string;
};

describe('mergeFeed', () => {
  it('sorts items by date descending', () => {
    const posts: TestFeedItem[] = [
      { date: new Date('2026-01-01'), type: 'post', slug: 'old', title: 'Old' },
      { date: new Date('2026-04-01'), type: 'post', slug: 'new', title: 'New' },
    ];
    const links: TestFeedItem[] = [
      { date: new Date('2026-02-15'), type: 'post', slug: 'mid', title: 'Mid' },
    ];

    const result = mergeFeed(posts, links);

    expect(result[0]?.slug).toBe('new');
    expect(result[1]?.slug).toBe('mid');
    expect(result[2]?.slug).toBe('old');
  });

  it('returns an empty array when all inputs are empty', () => {
    expect(mergeFeed([], [])).toEqual([]);
  });

  it('handles posts-only input', () => {
    const posts: TestFeedItem[] = [
      { date: new Date('2026-01-01'), type: 'post', slug: 'a', title: 'A' },
    ];

    const result = mergeFeed(posts, []);

    expect(result).toHaveLength(1);
    expect(result[0]?.type).toBe('post');
  });
});
