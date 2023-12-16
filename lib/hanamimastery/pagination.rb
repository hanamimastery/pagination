# frozen_string_literal: true

require 'dry-effects'
require 'hanamimastery/pagination/types'
require 'hanamimastery/pagination/page'
require 'hanamimastery/pagination/reader'

require_relative "pagination/version"

module Hanamimastery
  # Allows to paginate resources based on input parameters
  #
  module Pagination
    PaginationParamsError = Class.new(StandardError)
    PaginationUnsetError = Class.new(StandardError)

    def self.included(klass)
      klass.include Dry::Effects::Handler.Reader(:pagination)
    end

    # Sets the pagination object and throws it down the stack,
    #   Yields the block making pagination object accessible within
    # @param [Hash] pagination parameters
    # @example
    #   include Hanamimastery::Utiles::Pagination
    #   def handle(request, response)
    #     paginate(request.params) { render view }
    #   end
    #
    def paginate(params_hash = {}, &block)
      with_pagination(detect_page(params_hash)) do
        block.call if block_given?
      end
    end

    # @api_private
    # Based on the input hash, validate the schema and initialize the Page object
    # @param [Hash]
    # @return [Hanamimastery::Pagination::Page] a pagination page object with default values set
    #
    def detect_page(params_hash)
      page_params = Types::PaginationType[params_hash.to_h]
      Page.new(page_params[:page])
    rescue Dry::Types::SchemaError => e
      raise PaginationParamsError, e.message
    end
  end
end
