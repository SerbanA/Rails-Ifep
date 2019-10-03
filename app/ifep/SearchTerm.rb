require 'simple_command'
require_relative 'Filters'
 
module Ifep
    def SearchTerm 
       @body = body.gsub(/(?<=tbSearch=)\w+(?=\&)/, name)
    end
end

