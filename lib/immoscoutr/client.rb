# frozen_string_literal: true

require_relative "client/connection"
require_relative "client/requests"
require_relative "client/oauth"
require_relative "client/realestate_api"

module Immoscoutr
  # == Immoscoutr::Client
  # Is used internally when working with Immoscoutr directly.
  # Can be instanciated to work with multiple clients.
  class Client
    include Immoscoutr::Client::Connection
    include Immoscoutr::Client::Requests
    include Immoscoutr::Client::Oauth

    PRODUCTION_URI = "https://rest.immobilienscout24.de"
    SANDBOX_URI = "https://rest.sandbox-immobilienscout24.de"

    attr_accessor :api_version
    attr_accessor :consumer_key
    attr_accessor :consumer_secret
    attr_accessor :access_token
    attr_accessor :access_secret
    attr_accessor :sandbox
    attr_accessor :username

    def initialize(version: nil, consumer_key: , consumer_secret: , access_token: nil, access_secret: nil, sandbox: false, username: "me")
      self.api_version = version || ::Immoscoutr::API_VERSION
      self.consumer_key = consumer_key
      self.consumer_secret = consumer_secret
      self.access_token = access_token
      self.access_secret = access_secret
      self.sandbox = sandbox
      self.username = username
    end

    def url
      sandbox ? SANDBOX_URI : PRODUCTION_URI
    end

    def realestate
      @realestate ||= RealestateAPI.new(self)
    end
  end
end
