#!/usr/bin/env ruby
# frozen_string_literal: true

# Restructure posts into year-based bundle layout:
#   content/posts/YEAR/slug/index.md
#
# - Single .md files become leaf bundles
# - Existing bundles are moved and renamed (date prefix stripped)
# - redirects.csv is updated with clean destination URLs
#
# Usage:
#   ruby restructure_posts.rb --dry-run
#   ruby restructure_posts.rb

require "fileutils"
require "psych"

POSTS_DIR   = "content/posts"
REDIRECTS   = "redirects.csv"
DRY_RUN     = ARGV.include?("--dry-run")
DATE_PREFIX = /^\d{4}-\d{2}-\d{2}-/

def parse_frontmatter(path)
  text = File.read(path, encoding: "utf-8")
  return [nil, text] unless text.start_with?("---")
  parts = text.split(/^---[ \t]*$/, 3)
  return [nil, text] unless parts.length >= 3
  fm = Psych.safe_load(parts[1], permitted_classes: [Time, Date, DateTime])
  [fm, parts[2].lstrip]
rescue Psych::Exception => e
  warn "YAML error in #{path}: #{e.message}"
  [nil, text]
end

def extract_year(fm)
  date = fm["date"]
  return nil unless date
  date.respond_to?(:year) ? date.year.to_s : date.to_s[0, 4]
end

def clean_slug(name)
  name.sub(DATE_PREFIX, "")
end

moves = []

Dir.each_child(POSTS_DIR).sort.each do |entry|
  src = File.join(POSTS_DIR, entry)
  next if entry == "_index.md"

  if File.file?(src) && entry.end_with?(".md")
    fm, _body = parse_frontmatter(src)
    next unless fm

    year = extract_year(fm)
    next unless year

    slug     = clean_slug(File.basename(entry, ".md"))
    dst_dir  = File.join(POSTS_DIR, year, slug)

    moves << { type: :single, src: src, dst_dir: dst_dir, old_slug: File.basename(entry, ".md"), new_slug: slug }

  elsif File.directory?(src)
    index = File.join(src, "index.md")
    next unless File.exist?(index)

    fm, _body = parse_frontmatter(index)
    next unless fm

    year = extract_year(fm)
    next unless year

    slug    = clean_slug(entry)
    dst_dir = File.join(POSTS_DIR, year, slug)

    moves << { type: :bundle, src: src, dst_dir: dst_dir, old_slug: entry, new_slug: slug }
  end
end

puts "#{DRY_RUN ? "[DRY RUN] " : ""}#{moves.length} posts to restructure\n\n"
moves.each do |m|
  year = m[:dst_dir].split("/")[-2]
  puts "  #{m[:type].to_s.ljust(6)}  #{m[:old_slug]}  →  #{year}/#{m[:new_slug]}"
end
puts

exit 0 if DRY_RUN

# Build a slug map for updating redirects.csv
slug_map = moves.each_with_object({}) do |m, h|
  h[m[:old_slug]] = m[:new_slug]
end

# Perform moves
moves.each do |m|
  if m[:type] == :single
    FileUtils.mkdir_p(m[:dst_dir])
    FileUtils.cp(m[:src], File.join(m[:dst_dir], "index.md"))
    FileUtils.rm(m[:src])
  else
    FileUtils.mkdir_p(File.dirname(m[:dst_dir]))
    FileUtils.mv(m[:src], m[:dst_dir])
  end
end

# Update redirects.csv — fix destination URLs to use clean slugs
if File.exist?(REDIRECTS)
  lines = File.readlines(REDIRECTS, encoding: "utf-8")
  updated = lines.map do |line|
    from, to, code = line.chomp.split(",", 3)
    old_slug = from.to_s.split("/posts/").last.to_s.chomp("/")
    new_slug = slug_map[old_slug]
    if new_slug && to
      to = to.sub("/posts/#{old_slug}/", "/posts/#{new_slug}/")
    end
    "#{from},#{to},#{code}"
  end
  File.write(REDIRECTS, updated.join("\n") + "\n", encoding: "utf-8")
  puts "Updated redirects.csv"
end

puts "Done."
