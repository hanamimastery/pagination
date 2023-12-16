# frozen_string_literal: true

module Hanamimastery
  module Pagination
    module Reader
      def self.included(klass)
        klass.include Dry::Effects.Reader(:pagination)
        klass.define_method(:pagination) do
          super()
        rescue Dry::Effects::Errors::MissingStateError
          raise PaginationUnsetError, "You're trying to access pagination without setting it up."
        end
      end
    end
  end
end
