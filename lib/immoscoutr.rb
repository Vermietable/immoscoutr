# frozen_string_literal: true

require_relative "oauth_patch"
require_relative "immoscoutr/version"
require_relative "immoscoutr/client"
require_relative "immoscoutr/models/base"
require_relative "immoscoutr/models/realestate"
# require_relative 'immoscoutr/models/apartment_buy'
# require_relative 'immoscoutr/models/contact'
# require_relative 'immoscoutr/models/publish'
# require_relative 'immoscoutr/models/picture'
# require_relative 'immoscoutr/models/document'

module Immoscoutr
  class Error < StandardError; end
  class MissingConsumerCredentialsError < Error; end
  class AuthenticationError < Error; end

  API_VERSION = "1.0"

  class << self
    def api_version=(api_version)
      default_client.api_version = api_version
    end

    def consumer_key=(consumer_key)
      default_client.consumer_key = consumer_key
    end

    def consumer_secret=(consumer_secret)
      default_client.consumer_secret = consumer_secret
    end

    def access_token=(access_token)
      default_client.access_token = access_token
    end

    def access_secret=(access_secret)
      default_client.access_secret = access_secret
    end

    def sandbox=(sandbox)
      default_client.sandbox = sandbox
    end

    def get_request_token(callback_url)
      default_client.get_request_token(callback_url)
    end

    def get_access_token(request_token, request_secret, verifier)
      default_client.get_access_token(request_token, request_secret, verifier)
    end

    def realestate
      default_client.realestate
    end

    private

    def default_client
      @default_client ||= Client.new
    end
  end
end
