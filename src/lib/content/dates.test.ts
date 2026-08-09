import { afterEach, beforeEach, describe, expect, it } from 'vitest';
import { formatPostDate } from './dates';

describe('formatPostDate', () => {
  const originalTz = process.env.TZ;

  beforeEach(() => {
    process.env.TZ = 'America/New_York';
  });

  afterEach(() => {
    process.env.TZ = originalTz;
  });

  it('formats a date-only frontmatter value as its own calendar day, not the previous day in a western timezone', () => {
    expect(formatPostDate(new Date('2026-08-01'))).toBe('Aug 1, 2026');
  });
});
