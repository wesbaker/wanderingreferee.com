#!/usr/bin/env ruby
# frozen_string_literal: true

# Create a new post with pre-filled frontmatter.
#
# Usage:
#   ruby new_post.rb "My Post Title"
#   ruby new_post.rb "My Post Title" --link https://example.com
#   ruby new_post.rb "Review: Sky ov Crimson Flame" --folder
#
# Flags:
#   --link <url>   Makes this a link post (adds externalUrl to frontmatter)
#   --folder       Creates src/content/posts/slug/index.md instead of slug.md
#                  Use for posts that will have co-located images

require 'date'
require 'fileutils'
require 'yaml'

flags  = ARGV.select { |a| a.start_with?('--') }
args   = ARGV.reject { |a| a.start_with?('--') }

title       = args.join(' ')
link_index  = ARGV.index('--link')
link        = link_index ? ARGV[link_index + 1] : nil
folder_mode = flags.include?('--folder')

abort 'Usage: ruby new_post.rb "Post Title" [--link URL] [--folder]' if title.empty?

slug = title.downcase
             .gsub(/[''"":]/, '')
             .gsub(/[^a-z0-9]+/, '-')
             .sub(/^-+/, '')
             .sub(/-+$/, '')

base = File.join(__dir__, 'src', 'content', 'posts')

if folder_mode
  dir  = File.join(base, slug)
  abort "Already exists: #{dir}" if File.exist?(dir)
  FileUtils.mkdir_p(dir)
  path = File.join(dir, 'index.md')
else
  path = File.join(base, "#{slug}.md")
  abort "Already exists: #{path}" if File.exist?(path)
end

frontmatter = {
  'title'  => title,
  'date'   => Date.today.to_s,
  'tags'   => [],
  'draft'  => true,
}
frontmatter['externalUrl'] = link if link

body = "---\n#{frontmatter.to_yaml.sub(/\A---\n/, '')}---\n\n"
File.write(path, body)

puts "Created: #{path}"
puts "  slug:   #{slug}"
puts "  draft:  true"
puts "  link:   #{link}" if link
puts "  folder: #{folder_mode}"
