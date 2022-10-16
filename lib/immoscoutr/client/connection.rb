# frozen_string_literal: true

require "faraday"
require "faraday/encoding"
require "faraday/multipart"
require "faraday/follow_redirects"

module Immoscoutr
  class Client
    module Connection
      def connection
        @connection ||= Faraday::Connection.new(url: url) do |builder|
          builder.request :multipart
          builder.request :url_encoded
          builder.request :json
          builder.use Faraday::FollowRedirects::Middleware
          builder.response :encoding
          builder.response :json, content_type: /\bjson$/
          builder.adapter :net_http
        end
      end
    end
  end
end
