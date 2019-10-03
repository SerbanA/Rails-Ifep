require 'simple_command'
require 'nokogiri'
require 'Filters'

module Ifep
    class ParseData
        prepend SimpleCommand

        def initialize(raw_data)
            @raw_data = raw_data
        end

        def call
            document = Nokogiri::HTML(@raw_data)
            count = document.search('.col-md-12').count
            lawyer = []
            for i in 0..count-1 do
                chunk = document.search('.col-md-12')[i]
                lawyer[i] = extract_info(chunk)
            end
            return lawyer
        end

        def extract_info(chunk)
            person = OpenStruct.new(:job => chunk.search('h4 span[class^="label label"]').text,
            :name => chunk.search('h4 [style="font-weight:bold;"]').text,
            :state => chunk.search('h4 span[style^="color:"]').text,
            :phone => chunk.search('[class="padding-right-md text-primary"]').text,
            :mail => chunk.search('[class="text-nowrap"]').text)
        end
    end
end
