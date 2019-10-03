require_relative 'Filters'
module Ifep
    class MainProgram
        prepend SimpleCommand
        
        def initialize(headers,body)
            @headers = headers
            @body = body
        end

        def call
            command = Ifep::ObtainCookie.call(@headers)
            p "Obtaining cookie"
            if command.success?  
                p "Obtained cookie"
                cookie = command.result 
                command = Ifep::UpdateCookie.call(cookie, @headers)
                puts "Updating Cookie"
                if command.success?
                    p "Updated Cookie"  
                    name= params[:term]
                    command = Ifep::SearchTerm.call(@body, name)
                    @body = command.result
                    command = Ifep::LawyerPanel.call(@headers, @body)
                    if command.success?
                        raw_data = command.result 
                        command = Ifep::ParseData.call(raw_data)
                    else
                        puts command.errors[:fetch_lawyers]
                    end
                end
            else
                puts command.errors[:fetch_cookie]
            end
        end