require 'simple_command'
require_relative 'Filters'
 
module Ifep
    class SearchTerm
        prepend SimpleCommand

        def initialize(body,name)
            @name = name
            @body = body
        end

        def call 
            @body = body.gsub(/(?<=tbSearch=)\w+(?=\&)/, name)
        end
    end
end

