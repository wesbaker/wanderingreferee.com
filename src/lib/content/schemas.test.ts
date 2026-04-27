import { describe, expect, it } from 'vitest';
import { postSchema, slugFromMarkdownEntry } from './schemas';

describe('postSchema', () => {
  it('accepts current Hugo post frontmatter and normalizes blank tags', () => {
    const parsed = postSchema.parse({
      title: 'Review: Spire',
      date: '2018-11-13 18:45:00.000000000 -04:00',
      tags: null,
      summary: 'A PbtA game about being an oppressed drow elf revolutionary.',
    });

    expect(parsed.tags).toEqual([]);
    expect(parsed.draft).toBe(false);
    expect(parsed.xml).toBe(true);
    expect(parsed.date).toBeInstanceOf(Date);
  });

  it('keeps Hugo/Congo image metadata as optional strings', () => {
    const parsed = postSchema.parse({
      title: 'Portal',
      date: new Date('2020-08-30T15:00:00.000Z'),
      tags: ['RPGaDAY'],
      image: '/posts/rpgaday-portal/dungeon-door-lois-romer.jpg',
    });

    expect(parsed.image).toBe('/posts/rpgaday-portal/dungeon-door-lois-romer.jpg');
  });

  it('accepts link posts as regular posts with an external URL', () => {
    const parsed = postSchema.parse({
      title: 'Cool Article',
      date: '2026-04-20',
      externalUrl: 'https://example.com/article',
    });

    expect(parsed.externalUrl).toBe('https://example.com/article');
    expect(parsed.tags).toEqual([]);
    expect(parsed.draft).toBe(false);
    expect(parsed.date).toBeInstanceOf(Date);
  });
});

describe('slugFromMarkdownEntry', () => {
  it('uses a flat Markdown filename as the entry slug', () => {
    expect(slugFromMarkdownEntry('spire.md')).toBe('spire');
  });

  it('rejects paths that are not Markdown entries', () => {
    expect(() => slugFromMarkdownEntry('2018/spire/index.html')).toThrow(
      'Expected a Markdown entry path',
    );
  });
});
