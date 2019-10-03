require_relative 'filters'
module Ifep
    class MainProgram
        prepend SimpleCommand
        
        def initialize(headers,body)
            @headers = headers
            @body = body
        end

        def call
            command = ObtainCookie.call(@headers)
            if command.success?  
                cookie = command.result 
                Ifep::update_cookie(cookie, @headers)
                if command.success?  
                    name= params[:term]
                    command = SearchTerm.call(@body, name)
                    @body = command.result
                    command = LawyerPanel.call(@headers, @body)
                    if command.success?
                        raw_data = command.result 
                        command = ParseData.call(raw_data)
                    else
                        puts command.errors[:fetch_lawyers]
                    end
                end
            else
                puts command.errors[:fetch_cookie]
            end
        end

    end
end