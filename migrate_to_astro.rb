#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'fileutils'
require 'yaml'

ROOT = __dir__
CONTENT_DIR = File.join(ROOT, 'content', 'posts')
POSTS_OUT = File.join(ROOT, 'src', 'content', 'posts')
PUBLIC_POSTS_OUT = File.join(ROOT, 'public', 'posts')

STATIC_FILES = %w[
  apple-touch-icon.png
  favicon-16x16.png
  favicon-32x32.png
  favicon.svg
  site.webmanifest
].freeze

FileUtils.mkdir_p(POSTS_OUT)
FileUtils.mkdir_p(PUBLIC_POSTS_OUT)

def parse_frontmatter(text)
  if text.start_with?('+++')
    toml_block = text.match(/\A\+\+\+\n(.*?)\n\+\+\+\n/m)&.captures&.first
    return [{}, text] unless toml_block

    data = {}
    toml_block.each_line do |line|
      line = line.strip
      next if line.empty? || line.start_with?('#')

      key, value = line.split(/\s*=\s*/, 2)
      next unless key && value

      data[key] = parse_toml_value(value)
    end

    body = text.sub(/\A\+\+\+\n.*?\n\+\+\+\n/m, '')
    [data, body]
  elsif text.start_with?('---')
    yaml_block = text.match(/\A---\n(.*?)\n---\n/m)&.captures&.first
    return [{}, text] unless yaml_block

    data = YAML.safe_load(yaml_block, permitted_classes: [Date, Time], aliases: false) || {}
    body = text.sub(/\A---\n.*?\n---\n/m, '')
    [data, body]
  else
    [{}, text]
  end
end

def parse_toml_value(value)
  value = value.strip

  if value.start_with?("'") || value.start_with?('"')
    value[1..-2]
  elsif value.start_with?('[')
    value.scan(/'([^']*)'|"([^"]*)"/).map { |single, double| single || double }
  elsif value == 'true'
    true
  elsif value == 'false'
    false
  else
    value
  end
end

def cleaned_frontmatter(data, slug:, is_link:)
  cleaned = {}
  cleaned['title'] = data['title'] if present?(data['title'])
  cleaned['date'] = data['date'].to_s if present?(data['date'])
  cleaned['description'] = data['description'] || data['summary'] if present?(data['description'] || data['summary'])
  cleaned['tags'] = data['tags'] if data['tags'].is_a?(Array) && !data['tags'].empty?
  cleaned['draft'] = true if data['draft'] == true

  image = data['image'] || data['feature']
  cleaned['image'] = "/posts/#{slug}/#{image}" if present?(image) && !is_link

  if is_link
    cleaned['externalUrl'] = data['linkUrl'] || data['link']
  end

  cleaned
end

def present?(value)
  !value.nil? && value != ''
end

def rewrite_relative_asset_links(body, slug)
  body.gsub(%r{(\]\()\.\/([^)\s]+)(\))}, "\\1/posts/#{slug}/\\2\\3")
end

def copy_bundle_assets(source_dir, slug)
  files = Dir.glob(File.join(source_dir, '*')).reject { |path| File.directory?(path) || File.basename(path) == 'index.md' }
  return if files.empty?

  out_dir = File.join(PUBLIC_POSTS_OUT, slug)
  FileUtils.mkdir_p(out_dir)
  files.each { |file| FileUtils.cp(file, File.join(out_dir, File.basename(file))) }
end

def write_markdown(file, frontmatter, body)
  yaml_body = frontmatter.empty? ? '' : frontmatter.to_yaml.sub(/\A---\n/, '')
  File.write(file, "---\n#{yaml_body}---\n#{body.lstrip}")
end

Dir.glob(File.join(CONTENT_DIR, '**', 'index.md')).sort.each do |file|
  text = File.read(file)
  data, body = parse_frontmatter(text)
  slug = File.basename(File.dirname(file))
  is_link = present?(data['linkUrl']) || present?(data['link'])
  cleaned = cleaned_frontmatter(data, slug: slug, is_link: is_link)
  migrated_body = rewrite_relative_asset_links(body, slug)

  copy_bundle_assets(File.dirname(file), slug)

  out_file = File.join(POSTS_OUT, "#{slug}.md")
  write_markdown(out_file, cleaned, migrated_body)

  puts "#{is_link ? 'link' : 'post'}: #{slug}"
end

FileUtils.mkdir_p(File.join(ROOT, 'public', 'fonts'))
FileUtils.mkdir_p(File.join(ROOT, 'public', 'covers'))
FileUtils.cp(Dir.glob(File.join(ROOT, 'static', 'fonts', '*.woff2')), File.join(ROOT, 'public', 'fonts'))
FileUtils.cp(Dir.glob(File.join(ROOT, 'static', 'covers', '*')), File.join(ROOT, 'public', 'covers'))

STATIC_FILES.each do |filename|
  source = File.join(ROOT, 'static', filename)
  FileUtils.cp(source, File.join(ROOT, 'public', filename)) if File.exist?(source)
end

puts "\nDone. Posts in src/content/posts/, public assets copied."
