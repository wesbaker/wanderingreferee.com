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
      customData: '<byline:author ref="wes"/><byline:perspective>personal</byline:perspective>',
    }))
    .sort((a, b) => b.pubDate.valueOf() - a.pubDate.valueOf());

  return rss({
    title: 'Wandering Referee',
    description: 'Tabletop games, RPGs, and miniature painting.',
    site: context.site ?? 'https://wanderingreferee.com',
    xmlns: { byline: 'https://bylinespec.org/1.0' },
    items,
    customData: `<language>en-us</language>
<byline:person id="wes">
  <byline:name>Wes Baker</byline:name>
  <byline:context>Tabletop gamer, RPG referee, and miniature painter based in Fredericksburg, VA.</byline:context>
  <byline:url>https://wanderingreferee.com</byline:url>
  <byline:profile href="https://hachyderm.io/@wesbaker" rel="mastodon"/>
  <byline:profile href="https://bsky.app/profile/wesbaker.com" rel="bluesky"/>
  <byline:profile href="https://github.com/wesbaker" rel="github"/>
</byline:person>`,
  });
}
