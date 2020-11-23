module Graphql::Queries
  Sample = Graphql::Client.parse <<-'GRAPHQL'
    query {
      viewer {
        login
      }
    }
  GRAPHQL
end
