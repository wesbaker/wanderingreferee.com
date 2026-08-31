import { spawnSync } from 'node:child_process';
import { describe, expect, it } from 'vitest';

describe('Astro configuration', () => {
  it('type-checks without using deprecated Markdown plugin options', () => {
    const result = spawnSync('npx', ['astro', 'check'], {
      cwd: process.cwd(),
      encoding: 'utf8',
    });

    expect(result.status).toBe(0);
    expect(`${result.stdout}${result.stderr}`).not.toContain(
      'markdown.remarkPlugins',
    );
  });
});
