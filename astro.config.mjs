// @ts-check
import mdx from '@astrojs/mdx';
import { unified } from '@astrojs/markdown-remark';
import sitemap from '@astrojs/sitemap';
import { defineConfig } from 'astro/config';
import { remarkMark } from 'remark-mark-highlight';

// https://astro.build/config
export default defineConfig({
  site: 'https://wanderingreferee.com',
  integrations: [mdx(), sitemap()],
  markdown: {
    processor: unified({
      remarkPlugins: [remarkMark],
    }),
  },
});
