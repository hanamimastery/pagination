# frozen_string_literal: true

require 'dry-types'

module Hanamimastery
  module Pagination
    # Ensures page parameters are of correct type
    #   or that values are coercible to defaults
    #
    Types = Dry.Types

    module Types
      DEFAULT_PAGE = 1
      DEFAULT_SIZE = 10

      PaginationType =
        Types::Hash.schema(
          page: Types::Hash.schema(
            size: Types::Coercible::Integer
                    .default(DEFAULT_SIZE)
                    .constructor do |value|
                      value.nil? ? Dry::Types::Undefined : value
                    end.constrained(gteq: 1, lteq: 50),
            number: Types::Coercible::Integer
                    .default(DEFAULT_PAGE)
                    .constructor do |value|
                      value.nil? ? Dry::Types::Undefined : value
                    end.constrained(gteq: 1)
          ).with_key_transform(&:to_sym)
        )
                  .with_key_transform(&:to_sym)
                  .constructor do |value|
          value.nil? || value.to_h.empty? ? { page: {} } : value
        end
    end
  end
end
