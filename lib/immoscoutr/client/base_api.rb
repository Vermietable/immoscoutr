# frozen_string_literal: true

module Immoscoutr
  class Client
    class BaseAPI
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      def api_version; client.api_version; end
      def username; client.username; end

      def instantiate_list(list, klass)
        return [] if list.nil?

        list.map do |data|
          klass.new(data)
        end
      end
    end
  end
end
