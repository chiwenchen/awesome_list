module NestedAccessor
  extend ActiveSupport::Concern

  class_methods do
    def nested_accessor(jsonb_column, method_name, access_path = [], &block)
      define_method(method_name) do |&b|
        begin
          value = send(jsonb_column).dig(*access_path)
          block_given? ? block.call(value) : value

        rescue StandardError => e
          nil
        end
      end

      define_method("#{method_name}=") do |value|
        key = access_path[-1]
        send(jsonb_column).dig(*access_path[0..-2]).store(key, value)
      end
    end
  end
end
