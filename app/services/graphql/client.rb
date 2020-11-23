require "graphql/client"
require "graphql/client/http"

module Graphql
  class Client

    class << self
      GITHUB_GRAPHQL_ENDPOPINT = 'https://api.github.com/graphql'

      delegate :parse, to: :client

      def query(*args)
        response = client.query(*args)
        response = Graphql::Response.new(response)

        fail GraphqlRequestError, response.error_sentence if response.fail?

        response
      end

      private

      def client
        @client ||= GraphQL::Client.new(
          schema: Rails.root.join("db/schema.json").to_s,
          execute: http_adapter
        )
      end

      def http_adapter
        GraphQL::Client::HTTP.new(GITHUB_GRAPHQL_ENDPOPINT) do
          def headers(context)
            unless token = ENV['GITHUB_ACCESS_KEY']
              # $ GITHUB_ACCESS_TOKEN=abc123 bin/rails server
              #   https://help.github.com/articles/creating-an-access-token-for-command-line-use
              fail GraphqlMissingKeyError, source: 'Github'
            end

            {
              "Authorization" => "Bearer #{token}"
            }
          end
        end
      end
    end
  end
end
