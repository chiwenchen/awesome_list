module Graphql
  class Response
    attr_reader :raw_response

    def initialize(raw_response)
      @raw_response = raw_response
    end

    def success?
      errors.blank?
    end

    def fail?
      !success?
    end

    # for successful response
    def json_data
      JSON.parse(raw_response.data.to_json)
    end

    # for failed response
    def error_sentence
      errors.messages['data'].to_sentence
    end

    private

    def errors
      raw_response.errors.all
    end
  end
end
