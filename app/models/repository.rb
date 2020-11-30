class Repository < ApplicationRecord
  belongs_to :category

  include NestedAccessor

  nested_accessor :raw_data, :url, ['data', 'repository', 'url']
  nested_accessor :raw_data, :fork_count, ['data', 'repository', 'forkCount']
  nested_accessor :raw_data, :star_count, ['data', 'repository', 'stargazerCount']
  nested_accessor :raw_data, :author_name, ['data', 'repository', 'pullRequests', 'nodes', 0, 'author', 'login']
  nested_accessor(:raw_data, :last_commit_pushed_at, ['data', 'repository', 'pullRequests', 'nodes', 0, 'commits', 'nodes', 0, 'commit', 'pushedDate']) {|value| value.to_datetime }
end
