# frozen_string_literal: true

require "oauth"

module Immoscoutr
  class Client
    module Oauth
      def get_request_token(callback_url)
        raise Immoscoutr::MissingConsumerCredentialsError unless consumer_present?
        oauth_consumer.get_request_token(oauth_callback: callback_url)
      end
  
      def get_access_token(oauth_token, request_secret, verifier)
        request_token = ::OAuth::RequestToken.from_hash(oauth_consumer, { oauth_token: oauth_token, oauth_token_secret: request_secret })
        oauth_access_token = request_token.get_access_token(oauth_verifier: verifier)
        self.access_token = oauth_access_token.token
        self.access_secret = oauth_access_token.secret
        oauth_access_token
      end

      def oauth_consumer
        @oauth_consumer ||= ::OAuth::Consumer.new(
          consumer_key,
          consumer_secret,
          site: url,
          request_token_path: "/restapi/security/oauth/request_token",
          authorize_path: "/restapi/security/oauth/confirm_access",
          access_token_path: "/restapi/security/oauth/access_token"
        )
      end

      private

      def consumer_present?
        consumer_key && consumer_secret
      end
    end
  end
end
