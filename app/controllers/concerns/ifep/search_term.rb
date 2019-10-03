require 'simple_command'
require_relative 'filters'
 
module Ifep
    def search_term 
       @body = body.gsub(/(?<=tbSearch=)\w+(?=\&)/, name)
    end
end

