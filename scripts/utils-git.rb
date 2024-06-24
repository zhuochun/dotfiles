# frozen_string_literal: true
require 'date'

# Parse git blame content
GIT_BLAME_REGEX = /.+? +\((.+?) +(\d{4}-\d\d-\d\d \d\d:\d\d:\d\d [\-\+]\d{4}) +\d+\) .*/

def parse_git_blame(content)
  return {} if content.empty?

  modified_by = {}
  content.split(/\n/).each do |l|
    m = GIT_BLAME_REGEX.match(l)
    next if m.nil?

    author = m[1]
    next if author == 'Not Committed Yet'

    modified = modified_by[author] || { count: 0, last_edit_at: DateTime.new(0) }
    modified[:count] += 1
    modified[:last_edit_at] = [DateTime.parse(m[2]), modified[:last_edit_at]].max

    modified_by[author] = modified
  end
  modified_by
end

# Parse Phabricator Formatted Commit Message
PHAB_COMMIT_KEYS = {
  'Summary:' => :summary,
  'Test Plan:' => :test_plan,
  'Reviewers:' => :reviewers,
  'Reviewed By:' => :reviewed_by,
  'Subscribers:' => :subscribers,
  'Differential Revision:' => :revision
}.freeze

PHAB_COMMIT_KEYS_REGEX = /\n *\n *(#{PHAB_COMMIT_KEYS.keys.join('|')})/

def parse_phab_commit(commit_msg)
  title, key, rest = commit_msg.partition(PHAB_COMMIT_KEYS_REGEX)
  commit = { title: title.to_s.strip }
  # parse the rest of contents
  until rest.empty?
    content, next_key, rest = rest.partition(PHAB_COMMIT_KEYS_REGEX)

    akey = PHAB_COMMIT_KEYS[key.strip]
    commit[akey] = content.strip if akey

    key = next_key
  end

  # convert array fields
  commit[:reviewers] = commit[:reviewers].to_s.split(', ')
  commit[:reviewed_by] = commit[:reviewed_by].to_s.split(', ')
  commit[:subscribers] = commit[:subscribers].to_s.split(', ')

  commit
end

def commit_git(path, msg)
  git_repo = `git -C #{path} rev-parse --show-toplevel`.chop

  STDOUT << "COMMIT #{git_repo}\n"
  commit_changes = `git -C "#{git_repo}" add .`
  STDOUT << commit_changes << "\n"

  msg = msg.gsub('"', "'")
  commit = `git -C "#{git_repo}" commit -m "#{msg}"`
  STDOUT << commit << "\n"
end
