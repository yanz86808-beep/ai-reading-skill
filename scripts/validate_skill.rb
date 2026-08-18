#!/usr/bin/env ruby
# frozen_string_literal: true

require "yaml"

ROOT = File.expand_path("..", __dir__)
SKILL_DIR = File.join(ROOT, "skills", "ai-reading")
SKILL_FILE = File.join(SKILL_DIR, "SKILL.md")
AGENT_FILE = File.join(SKILL_DIR, "agents", "openai.yaml")

errors = []

def load_yaml(path, errors)
  YAML.safe_load(File.read(path), permitted_classes: [], aliases: false)
rescue StandardError => e
  errors << "#{path.delete_prefix(ROOT + "/")}: invalid YAML (#{e.message})"
  nil
end

unless File.file?(SKILL_FILE)
  errors << "skills/ai-reading/SKILL.md is missing"
else
  content = File.read(SKILL_FILE)
  parts = content.split(/^---\s*$\n/, 3)

  if parts.length < 3 || !content.start_with?("---\n")
    errors << "SKILL.md must start with YAML frontmatter"
  else
    metadata = YAML.safe_load(parts[1], permitted_classes: [], aliases: false)
    unless metadata.is_a?(Hash)
      errors << "SKILL.md frontmatter must be a mapping"
    else
      allowed = %w[description name]
      extra = metadata.keys.map(&:to_s) - allowed
      missing = allowed.reject { |key| metadata[key].is_a?(String) && !metadata[key].strip.empty? }
      errors << "SKILL.md has unsupported frontmatter keys: #{extra.join(', ')}" unless extra.empty?
      errors << "SKILL.md is missing: #{missing.join(', ')}" unless missing.empty?
      errors << "Skill name must be ai-reading" unless metadata["name"] == "ai-reading"
      errors << "Skill name must use lowercase letters, digits, and hyphens" unless metadata["name"].to_s.match?(/\A[a-z0-9-]{1,64}\z/)
    end
  end

  line_count = content.lines.count
  errors << "SKILL.md has #{line_count} lines; keep it under 500" if line_count >= 500

  references = content.scan(/\]\((references\/[A-Za-z0-9._-]+\.md)\)/).flatten.uniq
  references.each do |relative|
    errors << "Missing referenced file: #{relative}" unless File.file?(File.join(SKILL_DIR, relative))
  end
end

unless File.file?(AGENT_FILE)
  errors << "skills/ai-reading/agents/openai.yaml is missing"
else
  agent = load_yaml(AGENT_FILE, errors)
  interface = agent.is_a?(Hash) ? agent["interface"] : nil
  unless interface.is_a?(Hash)
    errors << "openai.yaml must contain an interface mapping"
  else
    %w[display_name short_description default_prompt].each do |key|
      errors << "openai.yaml interface.#{key} is missing" unless interface[key].is_a?(String) && !interface[key].strip.empty?
    end
    prompt = interface["default_prompt"].to_s
    errors << "openai.yaml default_prompt should mention $ai-reading" unless prompt.include?("$ai-reading")
  end
end

allowed_skill_entries = %w[SKILL.md agents assets references scripts]
if Dir.exist?(SKILL_DIR)
  unexpected = Dir.children(SKILL_DIR) - allowed_skill_entries
  errors << "Unexpected files inside Skill folder: #{unexpected.join(', ')}" unless unexpected.empty?
end

public_paths = %w[README.md README.zh-CN.md LICENSE CONTRIBUTING.md SECURITY.md skills evals examples scripts .github]
public_files = public_paths.flat_map do |relative|
  path = File.join(ROOT, relative)
  if File.file?(path)
    [path]
  elsif Dir.exist?(path)
    Dir.glob(File.join(path, "**", "*"), File::FNM_DOTMATCH).select { |entry| File.file?(entry) }
  else
    []
  end
end

sensitive_patterns = {
  "local user path" => %r{/Users/[^/\s]+/},
  "WorkBuddy private path" => %r{\.workbuddy/},
  "private key" => /BEGIN (?:RSA |OPENSSH |EC )?PRIVATE KEY/,
  "likely secret assignment" => /(?:api[_-]?key|client[_-]?secret|access[_-]?token|password)\s*[:=]\s*["']?[A-Za-z0-9_\-]{12,}/i
}

public_files.uniq.each do |path|
  next if File.expand_path(path) == File.expand_path(__FILE__)

  content = File.read(path, mode: "rb").force_encoding("UTF-8")
  next unless content.valid_encoding?

  sensitive_patterns.each do |label, pattern|
    errors << "#{path.delete_prefix(ROOT + "/")}: contains #{label}" if content.match?(pattern)
  end

  next unless File.extname(path).downcase == ".md"

  content.scan(/\]\(([^)]+)\)/).flatten.each do |target|
    clean_target = target.strip.split(/[?#]/, 2).first
    next if clean_target.empty? || clean_target.match?(%r{\A(?:https?://|mailto:)})

    resolved = File.expand_path(clean_target, File.dirname(path))
    errors << "#{path.delete_prefix(ROOT + "/")}: broken local link #{target}" unless File.exist?(resolved)
  end
end

%w[README.md README.zh-CN.md .gitignore CONTRIBUTING.md SECURITY.md].each do |required|
  errors << "#{required} is missing" unless File.file?(File.join(ROOT, required))
end

gitignore_file = File.join(ROOT, ".gitignore")
if File.file?(gitignore_file)
  ignore_rules = File.readlines(gitignore_file, chomp: true)
  errors << ".gitignore must exclude /runs/" unless ignore_rules.include?("/runs/")
  errors << ".gitignore must exclude /reviews/" unless ignore_rules.include?("/reviews/")
end

license_file = File.join(ROOT, "LICENSE")
if !File.file?(license_file)
  errors << "LICENSE is missing"
elsif !File.read(license_file).start_with?("MIT License\n")
  errors << "LICENSE is not the expected MIT License"
end

if errors.empty?
  puts "AI Reading release validation passed."
  exit 0
end

warn "AI Reading release validation failed with #{errors.length} issue(s):"
errors.each { |error| warn "- #{error}" }
exit 1
