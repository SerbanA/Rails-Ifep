require 'simple_command'
require_relative 'filters'

module Ifep
    def self.update_cookie(cookie, headers)
        headers['cookie'] = cookie
    end
end