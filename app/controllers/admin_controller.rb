class AdminController < ApplicationController
    before_action :generate_uuid

    def generate_uuid
        params[:UUID] = SecureRandom.uuid
        @UUID = params[:UUID]   
    end
  
    def search_results 
        command = Ifep::MainProgram.call(Ifep::Filters.headers, Ifep::Filters.form["body"], params[:search_value])
        @search_value = params[:search_value]
        @lawyer = command.result
        @status = params[:commit]
    end

    def validate_lawyer
        @status = params[:commit]
        message = if lawyer_ok?
            "This lawyer's data is OK and will be submitted to /api/lawyer/#{@UUID}/verify/#{params[:commit]}"
        else 
            "This lawyer's data is NOT-OK and will be submitted to /api/lawyer/#{@UUID}/verify/#{params[:commit]}"
        end

        render html: message
    end
    
    private
    
    def lawyer_ok?
        params[:commit] == "OK"
    end

end
