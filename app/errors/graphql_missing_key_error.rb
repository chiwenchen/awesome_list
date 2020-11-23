class GraphqlMissingKeyError < ApplicationError
  attr_accessor :source

  def post_initialize(source: 'GraphQL API Provider')
    @source = source
  end

  def message
    "Missing #{source} access token"
  end
end
