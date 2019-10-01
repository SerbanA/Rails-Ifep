require 'simple_command'
require_relative 'Filters'

module Ifep
    class UpdateCookie
        prepend SimpleCommand

        def initialize(cookie, headers)
            @cookie = cookie
            @headers = headers
        end

        def call
            headers['cookie'] = cookie
        end
    end
end