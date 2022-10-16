# frozen_string_literal: true

module Immoscoutr
  module Models
    class Realestate < Base
      property :id, alias: :@id
      property :external_id
      property :title
    end
  end
end
