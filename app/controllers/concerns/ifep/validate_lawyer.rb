require 'simple_command'

module Ifep
    def validate_lawyer
        if params[:commit] == "OK"
            p "This lawyer's data is OK and will be submitted to /api/lawyer/#{@UUID}/verify/#{params[:commit]}"
        elsif params[:commit] == "NOT-OK"
            p "This lawyer's data is NOT-OK and will be submitted to /api/lawyer/#{@UUID}/verify/#{params[:commit]}"
        end
    end
end