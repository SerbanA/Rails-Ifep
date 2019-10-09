require_relative 'filters'
module Ifep
    class MainProgram
        prepend SimpleCommand
        
        def initialize(headers,body,search_value)
            @headers = headers
            @body = body
            @search_value = search_value
        end

        def call
            command = ObtainCookie.call(@headers)
            if command.success?  
                cookie = command.result 
                update_headers_with_cookie(cookie)
                    if command.success? 
                        modify_search_term(@search_value)
                        command = LawyerPanel.call(@headers, @body)
                        if command.success?
                            raw_data = command.result 
                            command = ParseData.call(raw_data)
                            lawyer =  command.result
                            return lawyer
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

        def modify_search_term(search_value)
            @body = @body.gsub(/(?<=tbSearch=)\w+(?=\&)/, search_value)
        end

        def generate_uuid
            uuid = SecureRandom.uuid
        end
    end
 

end