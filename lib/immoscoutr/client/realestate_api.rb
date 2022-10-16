# frozen_string_literal: true

require_relative "base_api"

module Immoscoutr
  class Client
    class RealestateAPI < BaseAPI
      def all(page: 1, per_page: 20)
        response = client.get("restapi/api/offer/v#{api_version}/user/#{username}/realestate?pagesize=#{per_page}&pagenumber=#{page}")
        list = response.body["realestates.realEstates"]
        paging = list["Paging"].transform_keys(&:to_sym)
        realestate_list = instantiate_list(list["realEstateList"]["realEstateElement"], Immoscoutr::Models::Realestate)
        return realestate_list, paging
      end

      def find(id)
        response = client.get("restapi/api/offer/v#{api_version}/user/#{username}/realestate/#{id}")
        response.body["realestates.houseBuy"]
      end
    end
  end
end
