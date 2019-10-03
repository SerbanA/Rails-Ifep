require 'simple_command'
require_relative 'Filters'

module Ifep
    def UpdateCookie
        headers['cookie'] = cookie
    end
end