require_relative 'filters'
module Ifep
    class MainProgram
        prepend SimpleCommand
        
        def initialize(headers, body, params)
            @headers = headers
            @body = body
            @params = params
        end

        def call
            command = ObtainCookie.call(@headers)
            if command.success?  
                cookie = command.result 
                update_headers_with_cookie(cookie)
                if command.success?  
                    name = @params[:term]
                    p name.class
                    p @params[:term].class
                    modify_search_term(name)
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
        
        private
        def update_headers_with_cookie(cookie)
            @headers['cookie'] = cookie
        end

        def modify_search_term(name)
            @body = @body.gsub(/(?<=tbSearch=)\w+(?=\&)/, name)
        end
    end
 

end