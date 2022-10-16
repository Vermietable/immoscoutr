# frozen_string_literal: true

module Immoscoutr
  class Client
    module Requests
      def get(path, payload = nil, multipart = nil)
        request(:get, path, payload, multipart)
      end

      def post(path, payload = nil, multipart = nil)
        request(:post, path, payload, multipart)
      end

      def put(path, payload = nil, multipart = nil)
        request(:put, path, payload, multipart)
      end

      def delete(path, payload = nil, multipart = nil)
        request(:delete, path, payload, multipart)
      end

      # rubocop:disable Metrics/MethodLength because of the header handling
      def request(method, path, payload = nil, multipart = nil)
        connection.send(method, path, multipart) do |request|
          if multipart
            request.headers["Content-Type"] = "multipart/form-data"
          else
            request.body = payload if payload
            request.headers["Content-Type"] = "application/json;charset=UTF-8"
          end
          request.headers["Accept"] = "application/json"
          request.headers["User-Agent"] = "Vermietable/#{Immoscoutr::VERSION}"
          if access_token
            oauth_access_token = OAuth::AccessToken.from_hash(oauth_consumer, { oauth_token: access_token, oauth_token_secret: access_secret })
            oauth_params = { consumer: oauth_consumer, token: oauth_access_token }
            uri = connection.build_exclusive_url(path)
            oauth_helper = OAuth::Client::Helper.new(request, oauth_params.merge(request_uri: uri))
            request.headers["Authorization"] = oauth_helper.header
          end
        end
      end
    end
  end
end
