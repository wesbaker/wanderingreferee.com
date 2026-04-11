#!/usr/bin/env ruby
# frozen_string_literal: true

# Migrate Zola posts → Hugo (Congo theme)
# Run from: /Users/wesbaker/Projects/hobby-blog/
# Usage: ruby migrate_posts.rb [--dry-run]

require "fileutils"
require "psych"
require "set"

SRC   = "/Users/wesbaker/Projects/wesbaker.com/content/posts"
DST   = "/Users/wesbaker/Projects/hobby-blog/content/posts"
DRY   = ARGV.include?("--dry-run")

TARGET_TAGS  = %w[board-games rpgs rpgaday reviews].to_set
STRIP_KEYS   = %w[layout disqus cover].freeze
COVERS_REGEX = /\/covers\/([^\s"')>]+)/

migrated = 0
skipped  = 0
covers   = Set.new
redirects = []

def parse_frontmatter(text)
  return [nil, text] unless text.start_with?("---")

  # Find the closing ---
  rest = text[3..]
  end_idx = rest.index(/^---/)
  return [nil, text] unless end_idx

  fm_str = rest[0, end_idx].strip
  body   = rest[(end_idx + 3)..].lstrip
  [Psych.safe_load(fm_str, permitted_classes: [Time]), body]
rescue Psych::Exception
  [nil, text]
end

def collect_tags(fm)
  tags = Set.new
  if fm["tags"].is_a?(Array)
    tags.merge(fm["tags"].map(&:to_s))
  end
  if fm["taxonomies"].is_a?(Hash) && fm["taxonomies"]["tags"].is_a?(Array)
    tags.merge(fm["taxonomies"]["tags"].map(&:to_s))
  end
  tags
end

def has_target_tags?(fm, target_tags)
  !collect_tags(fm).intersection(target_tags).empty?
end

def build_output_fm(fm, target_tags, strip_keys)
  out = fm.dup

  # Merge tags from both locations
  merged = collect_tags(fm).to_a.sort
  out.delete("taxonomies")
  out["tags"] = merged unless merged.empty?

  # Remove Zola-specific keys
  strip_keys.each { |k| out.delete(k) }

  out
end

def fm_to_yaml(fm)
  Psych.dump(fm, line_width: -1).sub(/\A---\n/, "")
end

def slug_from_path(path)
  File.basename(path, ".md").sub(/^index$/, "").then do |s|
    s.empty? ? File.basename(File.dirname(path)) : s
  end
end

def old_url(slug)
  "https://wesbaker.com/posts/#{slug}/"
end

def new_url_placeholder(slug)
  "https://[newdomain]/posts/#{slug}/"
end

# Process a single .md file
process_single = lambda do |src_path|
  text = File.read(src_path, encoding: "utf-8")
  fm, body = parse_frontmatter(text)
  return false unless fm && has_target_tags?(fm, TARGET_TAGS)

  out_fm   = build_output_fm(fm, TARGET_TAGS, STRIP_KEYS)
  out_text = "---\n#{fm_to_yaml(out_fm)}---\n\n#{body}"

  dst_path = File.join(DST, File.basename(src_path))
  slug     = File.basename(src_path, ".md")
  puts "  MIGRATE single: #{File.basename(src_path)}"

  unless DRY
    FileUtils.mkdir_p(DST)
    File.write(dst_path, out_text, encoding: "utf-8")
  end

  [slug, out_text]
end

# Process a bundle directory
process_bundle = lambda do |src_dir|
  index_path = File.join(src_dir, "index.md")
  return false unless File.exist?(index_path)

  text = File.read(index_path, encoding: "utf-8")
  fm, body = parse_frontmatter(text)
  return false unless fm && has_target_tags?(fm, TARGET_TAGS)

  out_fm   = build_output_fm(fm, TARGET_TAGS, STRIP_KEYS)
  out_text = "---\n#{fm_to_yaml(out_fm)}---\n\n#{body}"

  slug     = File.basename(src_dir)
  dst_dir  = File.join(DST, slug)
  puts "  MIGRATE bundle: #{slug}"

  unless DRY
    FileUtils.rm_rf(dst_dir) if Dir.exist?(dst_dir)
    FileUtils.cp_r(src_dir, dst_dir)
    File.write(File.join(dst_dir, "index.md"), out_text, encoding: "utf-8")
  end

  [slug, out_text]
end

FileUtils.mkdir_p(DST) unless DRY

Dir.each_child(SRC).sort.each do |entry|
  full = File.join(SRC, entry)

  next if entry == "_index.md"

  result = if File.file?(full) && entry.end_with?(".md")
    process_single.call(full)
  elsif File.directory?(full)
    process_bundle.call(full)
  end

  if result
    slug, content = result
    migrated += 1
    redirects << [old_url(slug), new_url_placeholder(slug)]
    covers.merge(content.scan(COVERS_REGEX).flatten)
  else
    skipped += 1
    puts "  SKIP: #{entry}" if File.file?(full) && entry.end_with?(".md")
  end
end

# Write redirects.csv
unless DRY
  File.open("redirects.csv", "w") do |f|
    redirects.each do |(from, to)|
      f.puts "#{from},#{to},301"
    end
  end

  # Write covers_needed.txt
  File.open("covers_needed.txt", "w") do |f|
    covers.sort.each { |c| f.puts c }
  end
end

puts
puts "Done. Migrated: #{migrated}, Skipped: #{skipped}"
puts "Covers referenced: #{covers.size}"
puts "(DRY RUN — no files written)" if DRY
