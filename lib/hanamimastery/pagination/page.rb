# frozen_string_literal: true

require 'dry-struct'
require 'hanamimastery/pagination/types'

module Hanamimastery
  module Pagination
    class Page < Dry::Struct
      attribute :number, Types::Integer
      attribute :size, Types::Integer
    end
  end
end
