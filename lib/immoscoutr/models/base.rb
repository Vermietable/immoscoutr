# frozen_string_literal: true

module Immoscoutr
  module Models
    class Base
      def attributes
        self.class.properties.keys.sort
      end

      class << self
        def properties
          @@properties ||= {}
          @@properties
        end

        def property(name, **opts)
          attr_accessor(name)
          alias_name = opts.fetch(:alias, false)
          if alias_name
            alias_method alias_name, name
            alias_method "#{alias_name}=", "#{name}="
          end
          properties[name] = opts
        end

        def find_property(name)
          properties[name] || properties.values.detect do |value|
            value[:alias] == name
          end
        end
      end
    end
  end
end
