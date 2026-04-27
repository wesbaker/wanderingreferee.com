import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';
import type { APIContext } from 'astro';

export async function GET(context: APIContext) {
  const posts = await getCollection('posts', ({ data }) => !data.draft);

  const items = posts
    .map((post) => ({
      title: post.data.title,
      pubDate: post.data.date,
      description: post.data.description ?? '',
      link: `/posts/${post.id}/`,
    }))
    .sort((a, b) => b.pubDate.valueOf() - a.pubDate.valueOf());

  return rss({
    title: 'Wandering Referee',
    description: 'Tabletop games, RPGs, and miniature painting.',
    site: context.site ?? 'https://wanderingreferee.com',
    items,
    customData: '<language>en-us</language>',
  });
}
