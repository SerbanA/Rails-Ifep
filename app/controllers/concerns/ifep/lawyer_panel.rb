require 'uri'
require 'net/http'
require 'simple_command'
require_relative 'filters'

module Ifep
    class LawyerPanel
        prepend SimpleCommand

        def initialize(headers,body)
            @headers = headers
            @body = body
        end
        
        def call
            uri = URI.parse("https://www.ifep.ro/Justice/Lawyers/LawyersPanel.aspx")
            request = Net::HTTP.new(uri.host, uri.port)
            request.use_ssl = true
            response = request.post(uri.path, @body, @headers)
            status = response.code
            return response.body if "200" == status
            errors.add(:fetch_lawyers, error_message(response)) if status != "200"
        end
        
        def error_message(response)
            "Error when fetching lawyers list.#{response.code}:#{JSON.parse(response.body)["Message"]}" 
        end
    end
end
