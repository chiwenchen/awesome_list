class Repository < ApplicationRecord
  belongs_to :category

  def self.inspect_raw
    # normolize data before store if data is critical and must have.
    self.select(%Q(
      *,
      raw_data -> 'data' -> 'repository' ->> 'url' as url,
      (raw_data -> 'data' -> 'repository' ->> 'forkCount')::int as fork_count,
      (raw_data -> 'data' -> 'repository' ->> 'stargazerCount')::int as star_count,
      raw_data -> 'data' -> 'repository' -> 'pullRequests' -> 'nodes' -> 0 -> 'author' -> 'login' as author_name,
      TO_TIMESTAMP(raw_data -> 'data' -> 'repository' -> 'pullRequests' -> 'nodes' -> 0 -> 'commits' -> 'nodes' -> 0 -> 'commit' ->> 'pushedDate', 'YYYY-MM-DD%THH24:MI:SS%Z') as last_commit_pushed_at
    ))
  end
end
