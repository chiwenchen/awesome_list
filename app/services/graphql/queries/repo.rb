module Graphql::Queries
  Repo = Graphql::Client.parse <<-'GRAPHQL'
    query ($owner: String!, $repo_name: String!) {
      repository(owner: $owner, name: $repo_name) {
        name
        forkCount
        stargazerCount
        createdAt
        updatedAt
        url
        pullRequests(last: 1) {
          nodes {
            author {
              login
            }
            commits(last: 1) {
              nodes {
                commit {
                  pushedDate
                }
              }
            }
          }
        }
      }
    }
  GRAPHQL
end
